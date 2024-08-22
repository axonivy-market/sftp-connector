package com.axonivy.connector.sftp.test;

import ch.ivyteam.ivy.bpm.engine.client.element.BpmProcess;
import ch.ivyteam.ivy.environment.Ivy;
import ch.ivyteam.ivy.environment.IvyTest;

@IvyTest
public class BaseTest {
	protected static final String TEST_SFTP_SERVER_NAME = "dummy";
	protected static final String TEST_SFTP_SSH_SERVER_NAME = "dummy_ssh";
	
	protected static final BpmProcess TEST_HELPER_PROCESS = BpmProcess.path("Sftp/SftpHelper");
	protected static final BpmProcess TEST_UPLOAD_FILE_PROCESS = BpmProcess.path("Sftp/SftpUploadFile");
	protected static final BpmProcess TEST_DOWNLOAD_FILE_PROCESS = BpmProcess.path("Sftp/SftpDownloadFile");

	protected static final String PREFIX = "com.axonivy.connector.sftp.server";
	protected static final String TEST_FILE_NAME = "market_market_connector_sftp.pdf";
	protected static final long TEST_FILE_SIZE = 207569L;
	
	protected static void setVarForSFTPName(String sftpServerName, String username, String auth, String password, String sshKeyFilePath, String sshpassphrase) {
		setVar(sftpServerName, "host", "localhost");
		setVar(sftpServerName, "username", username);
		setVar(sftpServerName, "port", "22");
		setVar(sftpServerName, "auth", auth);
		setVar(sftpServerName, "password", password);
		setVar(sftpServerName, "sshkeyFilePath", sshKeyFilePath);
		setVar(sftpServerName, "sshPassphraseSecret", sshpassphrase);
	}
	
	private static void setVar(String sftpServerName, String var, String value) {
		Ivy.var().set(String.format("%s.%s.%s", PREFIX, sftpServerName, var), value);
	}
	
}
