package com.axonivy.connector.sftp.test;

import static org.assertj.core.api.Assertions.assertThat;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import com.axonivy.connector.sftp.service.SftpClientService;

import ch.ivyteam.ivy.bpm.engine.client.BpmClient;
import ch.ivyteam.ivy.bpm.exec.client.IvyProcessTest;
import ch.ivyteam.ivy.environment.Ivy;


/**
 * This SftpMultiConnectionTest creates 2 sFTP connections
 */
@IvyProcessTest(enableWebServer = true)
public class SftpMultiConnectionTest {

	private static final String PREFIX = "com.axonivy.connector.sftp.server.";
	
	private static final String SFTP_NAME = "dummy";
	private static final String SFTP_SSH_NAME = "dummy_ssh";
	private static final String SFTP_SSH_NAME_VAR = SFTP_SSH_NAME + ".";
	
	@BeforeEach
	public void preInit() throws Exception {
		// set-up variables for sftp connector with SSH key pair
		Ivy.var().set(PREFIX+SFTP_SSH_NAME_VAR+"host", "localhost");
		Ivy.var().set(PREFIX+SFTP_SSH_NAME_VAR+"username", "usr2ssh");
		Ivy.var().set(PREFIX+SFTP_SSH_NAME_VAR+"auth", "ssh");
		Ivy.var().set(PREFIX+SFTP_SSH_NAME_VAR+"password", "");
		String keyString = Files.readString(Paths.get(SftpProcessSSHTest.class.getResource("sftptest").toURI()));
		Ivy.var().set(PREFIX+SFTP_SSH_NAME_VAR+"secret.sshkey", keyString);
		Ivy.var().set(PREFIX+SFTP_SSH_NAME_VAR+"secret.sshpassphrase", "123456");
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
