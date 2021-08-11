package com.axonivy.connector.sftp.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import org.apache.log4j.Logger;
import org.springframework.core.io.ClassPathResource;
import org.springframework.integration.file.remote.session.CachingSessionFactory;
import org.springframework.integration.file.remote.session.Session;
import org.springframework.integration.sftp.session.DefaultSftpSessionFactory;

import com.jcraft.jsch.ChannelSftp;

import ch.ivyteam.ivy.environment.Ivy;


/**
 * Service class for file transfer to/from the SFTP server.
 * The service class is used to decouple the SFTP implementation.
 */
public class SftpClientService {
	private static final Logger LOG = Logger.getLogger(SftpClientService.class);
	private static final int SESSION_CACHE_SIZE = 10;
	private static final long SESSION_WAIT_TIMEOUT = 10000;
	
	
	private static SftpClientService instance;
	private DefaultSftpSessionFactory sftpSessionFactory;
	private CachingSessionFactory<ChannelSftp.LsEntry> cachingSessionFactory;
	
	
	/**
	 * Instantiates the SftpClientService object.
	 */
	private SftpClientService() {
		String hostname = Ivy.var().get("com.axonivy.connector.sftp.server.host");
		String username = Ivy.var().get("com.axonivy.connector.sftp.server.username");
		int port = 22;
		String privateKey = "META-INF/keys/sftpConnector_rsa.ppk";
		String privateKeyPassphrase = "sftpConnectorIntegration";
		
		String portValue = Ivy.var().get("com.axonivy.connector.sftp.server.port");
		try {
			port = Integer.parseInt(portValue);
		}
		catch(NumberFormatException nfe) {
			LOG.error("The Global Variable: com.axonivy.connector.sftp.server.port = " + portValue 
					+ " does not contain a number. The default port number: " + port + " will be used instead.", nfe);
		}
		
		LOG.debug("The following settings will be used to connect to the SFTP server: hostname: " + hostname 
				+ ", port: " + port + ", username: " + username);
		
		sftpSessionFactory = new DefaultSftpSessionFactory();
		sftpSessionFactory.setAllowUnknownKeys(true);
		sftpSessionFactory.setHost(hostname);
		sftpSessionFactory.setPort(port);
		sftpSessionFactory.setPrivateKey(new ClassPathResource(privateKey, getClass().getClassLoader()));
		sftpSessionFactory.setPrivateKeyPassphrase(privateKeyPassphrase);
		sftpSessionFactory.setUser(username);
		
		cachingSessionFactory = new CachingSessionFactory<>(sftpSessionFactory, SESSION_CACHE_SIZE);
		cachingSessionFactory.setSessionWaitTimeout(SESSION_WAIT_TIMEOUT);
	}
	
	
	public static SftpClientService getInstance() {
		if(instance == null) {
			instance = new SftpClientService();
		}
		return instance;
	}
	
	public Session<ChannelSftp.LsEntry> getSession() {
		return cachingSessionFactory.getSession();
	}

	public List<FileData> listAllFiles(String remoteDirectory) {
		List<FileData> listRemoteFiles = new ArrayList<>();
		try {
			listRemoteFiles = Arrays.stream(cachingSessionFactory.getSession().list(remoteDirectory))
					.map(e -> SftpClientService.convertLsEntryToFileData(e))
					.filter(f -> f.isFile())
					.collect(Collectors.toList());
		} catch (Exception e) {
			LOG.error("Error occurred while listing the files from the SFTP Server.", e);
		}
		return listRemoteFiles;
	}

	private static FileData convertLsEntryToFileData(ChannelSftp.LsEntry entry) {
		FileData data = new FileData();
		int i = entry.getLongname().lastIndexOf('/');
		data.parentPath = (i < 0) ? "" : entry.getLongname().substring(0, i);
		data.isDirectory = entry.getAttrs().isDir();
		data.isFile = !entry.getAttrs().isDir() && !entry.getAttrs().isLink();
		data.name = entry.getFilename();
		data.size = entry.getAttrs().getSize();
		data.modificationDate = new Date(1000L * entry.getAttrs().getMTime());
		
		return data;
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

