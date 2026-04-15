package com.axonivy.connector.sftp.test;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;
import static org.junit.jupiter.api.Assertions.assertThrows;

import java.nio.file.Paths;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import com.axonivy.connector.sftp.service.SftpClientService;

import ch.ivyteam.ivy.bpm.engine.client.BpmClient;
import ch.ivyteam.ivy.bpm.engine.client.element.BpmElement;
import ch.ivyteam.ivy.bpm.engine.client.sub.SubProcessCallResult;
import ch.ivyteam.ivy.bpm.exec.client.IvyProcessTest;
import ch.ivyteam.ivy.environment.Ivy;

/**
 * Test class for path validation in SftpClientService.
 * Tests path validation indirectly through public methods that call validation internally.
 */
@IvyProcessTest
class SftpClientServiceValidationTest extends BaseTest {
	private static SftpClientService sftpClient;

	@BeforeEach
	void setupSecureSFTP(BpmClient bpmClient) {
		String resourceDir = getClass().getResource(TEST_FILE_NAME).getPath();
		resourceDir = Paths.get(resourceDir).getParent().toString();
		setVarForSFTPName(TEST_SFTP_SERVER_NAME, "usr", "password", "pwd", "", "", "true");
		// Set base local directory to resource directory where test files are stored
		setVar(TEST_SFTP_SERVER_NAME, "baseLocalDir", resourceDir);
		sftpClient = initSftpClient(bpmClient);
	}

	private SftpClientService initSftpClient(BpmClient bpmClient) {
		BpmElement startable = TEST_HELPER_PROCESS.elementName("openConnection(String)");
		SubProcessCallResult result = bpmClient.start()
			.subProcess(startable)
			.execute(TEST_SFTP_SERVER_NAME) 
			.subResult();	
		return result.param("sftpClient", SftpClientService.class);
	}

	@Test
	void testGetFileDataWithValidPath() {
		assertDoesNotThrow(() -> {
			sftpClient.getFileData("validfile.txt");
		});
		sftpClient.close();
	}

	@Test
	void testGetFileDataWithInvalidPath() {
		assertThrows(SecurityException.class, () -> {
			sftpClient.getFileData("../../../etc/passwd");
		});
		sftpClient.close();
	}

	@Test
	void testUploadFileWithValidLocalPath() throws Exception {
		String filePath = getClass().getResource(TEST_FILE_NAME).getPath();
		assertDoesNotThrow(() -> {
			sftpClient.uploadFile(filePath, "remote.txt");
		});
		sftpClient.close();
	}

	@Test
	void testUploadFileWithInvalidLocalPath() {
		SftpClientService sftpClient = initSftpClient(bpmClient);
		assertThrows(SecurityException.class, () -> {
			sftpClient.uploadFile("../../../etc/passwd", "remote.txt");
		});
		sftpClient.close();
	}
}
