package com.axonivy.connector.sftp.test;

import static org.assertj.core.api.Assertions.assertThat;

import java.io.IOException;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import com.axonivy.connector.sftp.service.SftpClientService;

import ch.ivyteam.ivy.bpm.engine.client.BpmClient;
import ch.ivyteam.ivy.bpm.exec.client.IvyProcessTest;


/**
 * This SftpMultiConnectionTest creates 2 sFTP connections
 */
@IvyProcessTest(enableWebServer = true)
public class SftpMultiConnectionTest extends BaseTest {

	private static final String SFTP_NAME = "dummy";
	private static final String SFTP_SSH_NAME = "dummy_ssh";

	@BeforeEach
	public void preInit() throws Exception {
		setVarForSFTPName(TEST_SFTP_SERVER_NAME, "usr", "password", "pwd", "", "");
		String keyPath = SftpProcessSSHTest.class.getResource("sftptest").getPath();
		setVarForSFTPName(TEST_SFTP_SSH_SERVER_NAME, "usr2ssh", "ssh", "", keyPath, "123456");
	}

	@Test
	public void callOpenConnection(BpmClient bpmClient) throws IOException {
		SftpClientService sftpClient = new SftpClientService(SFTP_NAME);
		SftpClientService sftpSSHClient = new SftpClientService(SFTP_SSH_NAME);

		assertThat(sftpClient).isNotNull();
		assertThat(sftpSSHClient).isNotNull();
		sftpClient.close();
		sftpSSHClient.close();
	}
}
