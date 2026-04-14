package com.axonivy.connector.sftp.test;

import ch.ivyteam.ivy.bpm.engine.client.element.BpmProcess;
import ch.ivyteam.ivy.bpm.exec.client.IvyProcessTest;
import ch.ivyteam.ivy.environment.AppFixture;
import static com.axonivy.connector.sftp.constants.IvyVariableNames.*;

@IvyProcessTest
public class BaseTest {
	protected static final String TEST_SFTP_SERVER_NAME = "dummy";
	protected static final String TEST_SFTP_SSH_SERVER_NAME = "dummy_ssh";
	
	protected static final BpmProcess TEST_HELPER_PROCESS = BpmProcess.path("Sftp/SftpHelper");
	protected static final BpmProcess TEST_UPLOAD_FILE_PROCESS = BpmProcess.path("Sftp/SftpUploadFile");
	protected static final BpmProcess TEST_DOWNLOAD_FILE_PROCESS = BpmProcess.path("Sftp/SftpDownloadFile");

	protected static final String TEST_FILE_NAME = "market_market_connector_sftp.pdf";
	protected static final long TEST_FILE_SIZE = 207569L;
	
	protected static void setVarForSFTPName(String sftpServerName, String username, String auth, String password,
			String sshKeyFilePath, String sshpassphrase, AppFixture fixture) {
		setVarForSFTPName(sftpServerName, username, auth, password, sshKeyFilePath, sshpassphrase, "false", "", fixture);
	}

	protected static void setVarForSFTPName(String sftpServerName, String username, String auth, String password,
			String sshKeyFilePath, String sshpassphrase, String enforcePathRestrictions, String baseLocalDir, AppFixture fixture) {
		setVar(sftpServerName, HOST_VAR, "localhost", fixture);
		setVar(sftpServerName, USERNAME_VAR, username, fixture);
		setVar(sftpServerName, PORT_VAR, "22", fixture);
		setVar(sftpServerName, AUTH_VAR, auth, fixture);
		setVar(sftpServerName, PASSWORD_VAR, password, fixture);
		setVar(sftpServerName, SSHKEY_FILEPATH_VAR, sshKeyFilePath, fixture);
		setVar(sftpServerName, SECRET_SSHPASSPHRASE_VAR, sshpassphrase, fixture);
		setVar(sftpServerName, ENFORCE_PATH_RESTRICTIONS_VAR, enforcePathRestrictions, fixture);
		setVar(sftpServerName, BASE_LOCAL_DIR_VAR, baseLocalDir, fixture);
		setVar(sftpServerName, STRICT_HOST_KEY_CHECKING_VAR, "no", fixture);
	}

	protected static void setVar(String sftpServerName, String var, String value, AppFixture fixture) {
		fixture.var(String.format("%s.%s.%s", SFTP_VAR, sftpServerName, var), value);
	}
	
}
