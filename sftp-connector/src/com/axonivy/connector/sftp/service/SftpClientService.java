package com.axonivy.connector.sftp.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Properties;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;

import com.jcraft.jsch.ChannelSftp;
import com.jcraft.jsch.ChannelSftp.LsEntry;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.JSchException;
import com.jcraft.jsch.Session;
import com.jcraft.jsch.SftpException;


/**
 * Service class for file transfer to/from the SFTP server.
 * The service class is used to decouple the SFTP implementation.
 */
public class SftpClientService implements AutoCloseable {
	private static final Logger LOG = Logger.getLogger(SftpClientService.class);
	private static final String PATHSEPARATOR = "/";
	private static final int SESSION_TIMEOUT = 10000;
	private static final int CHANNEL_TIMEOUT = 5000;
	private static final String PASSWORD = "password";
	
	
	/**
	 * A Session represents a connection to an SSH server.
	 */
	private Session session;
	/**
	 * A Channel connected to an SFTP server (as a subsystem of the ssh server).
	 */
	private ChannelSftp channel;
	
	
	/**
	 * Instantiates the SftpClientService object with given the host, port, username and password.
	 * 
	 * @param host the host name
	 * @param authType authentication type: password, ssh
	 * @param port the port number
	 * @param username the user name
	 * @param password the password
	 * @param keyString the ssh key string
	 * @param passphrase the ssh passphrase
	 * @throws IOException
	 */
	public SftpClientService(String host, int port, String username, String authType, String password, String keyString, String passphrase) throws IOException {
		try {
			JSch jsch = new JSch();
			
			session = jsch.getSession(username, host, port);
			if (StringUtils.isEmpty(authType) || PASSWORD.equalsIgnoreCase(authType)) {
				session.setPassword(password);
			} else {
				session.setConfig("PreferredAuthentications", "publickey");
				jsch.addIdentity(null, keyString.getBytes(), null, passphrase.getBytes());
			}
			
			session.setConfig("StrictHostKeyChecking", "no");
			// 10 seconds session timeout
			session.connect(SESSION_TIMEOUT);
			
			channel = (ChannelSftp) session.openChannel("sftp");
			
			if (channel == null) {
				close();
				throw new IOException("Error while opening the channel to SFTP session '" + host + 
						"' with username '" + username + "'!");
			}
			// 5 seconds timeout
			channel.connect(CHANNEL_TIMEOUT);
		} catch (JSchException ex) {
			throw new IOException("Error while trying to connect to SFTP server '" + host + 
					"' with username '" + username + "': ", ex);
		}
	}
	
	/**
	 * Closes the current channel and the connection to the server.
	 */
	@Override
	public void close() {
		try {
			if (channel != null) {
				channel.disconnect();
				channel = null;
			}
		}
		finally {
			if (session != null) {
				session.disconnect();
				session = null;
			}
		}
	}
	
	/**
	 * Returns the current local directory in absolute form.
	 * 
	 * @return the current local directory
	 */
	public String getLocalCurrentDir() {
		return channel.lpwd();
	}
	
	/**
	 * Creates a new remote directory.
	 * 
	 * @param name
	 * @throws IOException
	 */
	public void makeRemoteDir(String name) throws IOException {
		try {
			channel.mkdir(name);
		}
		catch (SftpException ex) {
			throw new IOException(ex);
		}
	}
	
	/**
	 * Returns the current remote directory in absolute form.
	 * 
	 * @return the current remote directory
	 * @throws IOException
	 */
	public String getRemoteCurrentDir() throws IOException {
		try {
			return channel.pwd();
		}
		catch (SftpException ex) {
			throw new IOException(ex);
		}
	}
	
	/**
	 * Returns the File information of a single file.
	 * 
	 * @param remoteFilePath
	 * @return the File information
	 */
	public FileData getFileData(String remoteFilePath) {
		FileData fd = null;
		try {
			@SuppressWarnings("unchecked")
			List<ChannelSftp.LsEntry> lsEntryList = channel.ls(remoteFilePath);
			if (lsEntryList != null && !lsEntryList.isEmpty()) {
				LsEntry lsEntry = lsEntryList.get(0);
				
				fd = new FileData();
				int i = remoteFilePath.lastIndexOf('/');
				fd.parentPath = (i < 0) ? "" : remoteFilePath.substring(0, i);
				fd.isDirectory = lsEntry.getAttrs().isDir();
				fd.isFile = !lsEntry.getAttrs().isDir() && !lsEntry.getAttrs().isLink();
				fd.name = lsEntry.getFilename();
				fd.size = lsEntry.getAttrs().getSize();
				fd.modificationDate = new Date(1000L * lsEntry.getAttrs().getMTime());
			}
		}
		catch (SftpException ex) { // If an error occurs, null will be returned
			LOG.warn("If an error occurs, null will be returned", ex);
		}
		
		return fd;
	}
	
	/**
	 * Returns the list of all File information of all the files in a directory.
	 * 
	 * @param remoteDir
	 * @return
	 */
	public List<FileData> getFileDataList(String remoteDir) {
		List<FileData> fileDataList = new ArrayList<>();
		try {
			@SuppressWarnings("unchecked")
			List<ChannelSftp.LsEntry> lsEntryLst = channel.ls(remoteDir);
			for (LsEntry lsEntry : lsEntryLst) {
				FileData fd = new FileData();
				fd.parentPath = remoteDir;
				fd.isDirectory = lsEntry.getAttrs().isDir();
				fd.isFile = !lsEntry.getAttrs().isDir() && !lsEntry.getAttrs().isLink();
				fd.name = lsEntry.getFilename();
				fd.size = lsEntry.getAttrs().getSize();
				fd.modificationDate = new Date(1000L * lsEntry.getAttrs().getMTime());
				fileDataList.add(fd);
			}
		}
		catch (SftpException ex) { // If an error occurs, empty list will be returned
			LOG.warn("If an error occurs, empty list will be returned", ex);
		}
		return fileDataList;
	}
	
	/**
	 * Uploads a file from an input stream. 
	 * If the file is already existing in the remote directory, it will be overwritten.
	 * 
	 * @param is the source file, in form of an input stream.
	 * @param remoteDstFilePath the remote destination file name, relative to the current remote directory.
	 * @throws IOException
	 */
	public void uploadFile(InputStream is, String remoteDstFilePath) throws IOException {
		try {
			channel.put(is, remoteDstFilePath);
		}
		catch (SftpException ex) {
			throw new IOException(ex);
		}
	}
	
	/**
	 * Uploads a file. 
	 * If the file is already existing in the remote directory, it will be overwritten.
	 * 
	 * @param localSrcFilePath the local source file name, absolute or relative to the current local directory.
	 * @param remoteDstFilePath the remote destination file name, absolute or relative to the current remote directory.
	 * @throws IOException
	 */
	public void uploadFile(String localSrcFilePath, String remoteDstFilePath) throws IOException {
		try {
			channel.put(localSrcFilePath, remoteDstFilePath);
		}
		catch (SftpException ex) {
			throw new IOException(ex);
		}
	}
	
	/**
	 * Downloads a file to an OutputStream. This uses OVERWRITE mode and no progress monitor.
	 * 
	 * @param remoteSrcFilePath the source file name, relative to the current remote directory
	 * @param oStream the Output Stream
	 * @throws IOException
	 */
	public void downloadFile(String remoteSrcFilePath, OutputStream oStream) throws IOException {
		try {
			channel.get(remoteSrcFilePath, oStream);
		}
		catch (SftpException ex) {
			throw new IOException(ex);
		}
	}
	
	/**
	 * Downloads a file.
	 * If the file is already existing in the local directory, it will be overwritten.
	 * 
	 * @param remoteSrcFilePath the source file name, relative to the current remote directory.
	 * @param localDstFilePath the destination file name, relative to the current local directory.
	 * @throws IOException
	 */
	public void downloadFile(String remoteSrcFilePath, String localDstFilePath) throws IOException {
		try {
			channel.get(remoteSrcFilePath, localDstFilePath);
		}
		catch (SftpException ex) {
			throw new IOException(ex);
		}
	}
	
	/**
	 * Removes one remote file or one remote directory and its content.
	 * 
	 * @param path
	 * @throws IOException
	 */
	public void deleteRemoteFileOrDir(String path) throws IOException {
		FileData fd = getFileData(path);
		if(fd != null) {
			if(fd.isFile) {
				try {
					channel.rm(path); // Remove file
				} catch (SftpException ex) {
					throw new IOException(ex);
				}
			}
			else if(fd.isDirectory) {
				List<FileData> fileAndFolderList = getFileDataList(path); // List source directory structure
				
				for (FileData item : fileAndFolderList) { // Iterate objects in the list to get file/folder names
					if (item.isFile) { // If it is a file (not a directory)
						try {
							channel.rm(path + "/" + item.name); // Remove file
						} catch (SftpException ex) {
							throw new IOException(ex);
						}
					}
					else if (!(".".equals(item.name) || "..".equals(item.name))) { // If it is a subdir
						try {
							// removing sub directory.
							channel.rmdir(path + "/" + item.name);
						} catch (Exception ex) { // If subdir is not empty and error occurs, 
							// Do deleteRemoteFileOrDir on this subdir to enter it and clear its contents
							deleteRemoteFileOrDir(path + "/" + item.name);
							LOG.warn("If subdir is not empty and error occurs, Do deleteRemoteFileOrDir on this subdir to enter it and clear its contents", ex);
						}
					}
				}
				try {
					channel.rmdir(path); // delete the parent directory after empty
				} catch (SftpException ex) {
					throw new IOException(ex);
				}
			}
		}
	}
	
	/**
	 * Changes the current remote directory.
	 * This checks the existence and accessibility of the indicated directory, and changes the current remote directory setting.
	 * 
	 * @param path a directory path, absolute or relative to the current remote path.
	 * @throws IOException
	 */
	public void changeDir(String path) throws IOException {
		try {
			channel.cd(path);
		} catch (SftpException ex) {
			throw new IOException(ex);
		}
	}
	
	/**
	 * This method is called recursively to Upload the local folder content
	 * to the SFTP server remote directory.
	 * 
	 * @param sourcePath
	 */
	public void uploadAllFiles(String sourcePath) {
		File sourceFile = new File(sourcePath);
		File[] files = sourceFile.listFiles();
		for(File f : files) {
			if(f.isFile() && !f.getName().startsWith(".")) { // Copy if it is a file
				try {
					uploadFile(new FileInputStream(f), f.getName());
				} catch (IOException e) {
					LOG.error("Error occured while uploading", e);
				}
			}
			else {
				// Check if the directory is already existing
				FileData fileData = getFileData(f.getName());
				if (fileData != null) {
					LOG.debug("Directory exists IsDir=" + fileData.isDirectory);
				}
				else { // else create a directory
					LOG.debug("Creating dir " + f.getName());
					try {
						makeRemoteDir(f.getName());
					} catch (IOException e) {
						LOG.error("Error occured", e);
					}
				}
				try {
					changeDir(f.getName());
				} catch (IOException e1) {
					LOG.error("Error occured", e1);
				}
				
				uploadAllFiles(f.getAbsolutePath());
				
				try {
					changeDir("..");
				} catch (IOException e1) {
					LOG.error("Error occured", e1);
				}
			}
		}
	}

	/**
	 * This method is called recursively to download the remote folder content
	 * of the SFTP server.
	 * 
	 * @param sourcePath
	 * @param destinationPath
	 */
	public void downloadAllFiles(String sourcePath, String destinationPath) {
		List<FileData> fileAndFolderList = getFileDataList(sourcePath); // Let list of folder content
		// Iterate through list of folder content
		for (FileData item : fileAndFolderList) {
			if (!item.isDirectory) { // Check if it is a file (not a directory)
				try { // Download file from source (source filename, destination filename)
					downloadFile(sourcePath + PATHSEPARATOR + item.name, destinationPath + PATHSEPARATOR + item.name);
				} catch (IOException e) {
					LOG.error("Error occured while downloading", e);
				}
			} else if (!(".".equals(item.name) || "..".equals(item.name))) {
				// Empty folder copy
				new File(destinationPath + PATHSEPARATOR + item.name).mkdirs();
				// Enter found folder on server to read its contents and create locally
				downloadAllFiles(sourcePath + PATHSEPARATOR + item.name, destinationPath + PATHSEPARATOR + item.name);
			}
		}
	}
	
	/**
	 * Renames a file or directory.
	 * 
	 * @param oldpath the old name of the file, relative to the current remote directory.
	 * @param newpath the new name of the file, relative to the current remote directory.
	 * @throws IOException
	 */
	public void rename(String oldpath, String newpath) throws IOException {
		try {
			channel.rename(oldpath, newpath);
		} catch (SftpException ex) {
			throw new IOException(ex);
		}
	}
	
	
	/**
	 * File information class
	 *
	 */
	public static class FileData {
		boolean isFile;
		boolean isDirectory;
		String parentPath;
		String name;
		long size;
		/**
		 * The last modification date.
		 */
		Date modificationDate;
		
		/**
		 * @return the isFile
		 */
		public boolean isFile() {
			return isFile;
		}
		/**
		 * @param isFile the isFile to set
		 */
		public void setFile(boolean isFile) {
			this.isFile = isFile;
		}
		/**
		 * @return the isDirectory
		 */
		public boolean isDirectory() {
			return isDirectory;
		}
		/**
		 * @param isDirectory the isDirectory to set
		 */
		public void setDirectory(boolean isDirectory) {
			this.isDirectory = isDirectory;
		}
		/**
		 * @return the parentPath
		 */
		public String getParentPath() {
			return parentPath;
		}
		/**
		 * @param parentPath the parentPath to set
		 */
		public void setParentPath(String parentPath) {
			this.parentPath = parentPath;
		}
		/**
		 * @return the name
		 */
		public String getName() {
			return name;
		}
		/**
		 * @param name the name to set
		 */
		public void setName(String name) {
			this.name = name;
		}
		/**
		 * @return the size
		 */
		public long getSize() {
			return size;
		}
		/**
		 * @param size the size to set
		 */
		public void setSize(long size) {
			this.size = size;
		}
		/**
		 * @return the modificationDate
		 */
		public Date getModificationDate() {
			return modificationDate;
		}
		/**
		 * @param modificationDate the modificationDate to set
		 */
		public void setModificationDate(Date modificationDate) {
			this.modificationDate = modificationDate;
		}
	}
}

