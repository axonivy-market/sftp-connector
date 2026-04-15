package com.axonivy.connector.sftp.test;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;
import static org.junit.jupiter.api.Assertions.assertThrows;

import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;

import com.axonivy.connector.sftp.service.SftpClientService;

import ch.ivyteam.ivy.bpm.engine.client.BpmClient;
import ch.ivyteam.ivy.bpm.engine.client.element.BpmElement;
import ch.ivyteam.ivy.bpm.engine.client.sub.SubProcessCallResult;
import ch.ivyteam.ivy.environment.IvyTest;

/**
 * Test class for path validation in SftpClientService.
 * Tests path validation indirectly through public methods that call validation internally.
 */
@IvyTest
class SftpClientServiceValidationTest extends BaseTest {
	
	private static SftpClientService sftpClient;

	@BeforeAll
	static void setupSecureSFTP(BpmClient bpmClient) {
		setVarForSFTPName(TEST_SFTP_SERVER_NAME, "usr", "password", "pwd", "", "", "true");
		BpmElement startable = TEST_HELPER_PROCESS.elementName("openConnection(String)");
		SubProcessCallResult result = bpmClient.start()
			.subProcess(startable)
			.execute(TEST_SFTP_SERVER_NAME) 
			.subResult();	
		sftpClient = result.param("sftpClient", SftpClientService.class);
	}

	@Test
	void testGetFileDataWithValidPath() {
		assertDoesNotThrow(() -> {
			sftpClient.getFileData("validfile.txt");
		});
	}

	@Test
	void testGetFileDataWithInvalidPath() {
		assertThrows(SecurityException.class, () -> {
			sftpClient.getFileData("../../../etc/passwd");
		});
	}

	@Test
	void testUploadFileWithValidLocalPath() throws SecurityException {
		assertDoesNotThrow(() -> {
			sftpClient.uploadFile(System.getProperty("java.io.tmpdir") + "/validfile.txt", "remote.txt");
		});
	}

	@Test
	void testUploadFileWithInvalidLocalPath() {
		assertThrows(SecurityException.class, () -> {
			sftpClient.uploadFile("../../../etc/passwd", "remote.txt");
		});
	}
}
