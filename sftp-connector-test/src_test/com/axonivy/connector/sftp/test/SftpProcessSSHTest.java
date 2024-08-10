package com.axonivy.connector.sftp.test;

import static org.assertj.core.api.Assertions.assertThat;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;

import org.apache.commons.io.FileUtils;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Order;
import org.junit.jupiter.api.Test;

import com.axonivy.connector.sftp.service.SftpClientService;
import com.axonivy.connector.sftp.service.SftpClientService.FileData;

import ch.ivyteam.ivy.bpm.engine.client.BpmClient;
import ch.ivyteam.ivy.bpm.engine.client.element.BpmElement;
import ch.ivyteam.ivy.bpm.engine.client.element.BpmProcess;
import ch.ivyteam.ivy.bpm.engine.client.sub.SubProcessCallResult;
import ch.ivyteam.ivy.bpm.exec.client.IvyProcessTest;
import ch.ivyteam.ivy.environment.Ivy;
import ch.ivyteam.ivy.scripting.objects.File;


/**
 * This SftpProcessTest simulates SFTP operations by calling the sub processes: 
 * SftpUploadFile and SftpDownloadFile.
 * 
 * <p>The test can either be run<ul>
 * <li>in the Designer IDE ( <code>right click > run as > JUnit Test </code> )</li>
 * <li>or in a Maven continuous integration build pipeline ( <code>mvn clean verify</code> )</li>
 * </ul></p>
 * 
 * <p>Detailed guidance on writing these kind of tests can be found in our
 * <a href="https://developer.axonivy.com/doc/9.2/concepts/testing/process-testing.html">Process Testing docs</a>
 * </p>
 */
@IvyProcessTest(enableWebServer = true)
public class SftpProcessSSHTest {

	private static final BpmProcess TEST_HELPER_PROCESS = BpmProcess.path("Sftp/SftpHelper");
	private static final BpmProcess TEST_UPLOAD_FILE_PROCESS = BpmProcess.path("Sftp/SftpUploadFile");
	private static final BpmProcess TEST_DOWNLOAD_FILE_PROCESS = BpmProcess.path("Sftp/SftpDownloadFile");

	private static final String TEST_SFTP_NAME = "dummy";
	private static final String TEST_SFTP_NAME_VAR = TEST_SFTP_NAME + ".";
	private static final String TEST_FILE_NAME = "market_market_connector_sftp.pdf";
	private static final long TEST_FILE_SIZE = 207569L;

	private static final String PREFIX = "com.axonivy.connector.sftp.server.";
	
	@BeforeAll
	public static void init() throws Exception {
		
		Ivy.var().set(PREFIX+TEST_SFTP_NAME_VAR+"auth", "ssh");
		Ivy.var().set(PREFIX+TEST_SFTP_NAME_VAR+"password", "");
		
		String keyString = Files.readString(Paths.get(SftpProcessSSHTest.class.getResource("sftptest").toURI()));
		Ivy.var().set(PREFIX+TEST_SFTP_NAME_VAR+"secret.sshkey", keyString);
		Ivy.var().set(PREFIX+TEST_SFTP_NAME_VAR+"secret.sshpassphrase", "123456");
	}
	
	@Test
	@Order(1)
	public void callOpenConnection(BpmClient bpmClient) throws Exception {
		BpmElement startable = TEST_HELPER_PROCESS.elementName("openConnection(String)");
		
		SubProcessCallResult result = bpmClient.start()
			        .subProcess(startable)
			        .execute(TEST_SFTP_NAME) // Callable sub process input arguments 
			        .subResult();
		
		SftpClientService sftpClient = result.param("sftpClient", SftpClientService.class);
		assertThat(sftpClient).isNotNull();
		if (sftpClient != null) {
			sftpClient.close();
		}
	}

	 @Test
	 @Order(2)
	 public void callUploadFile(BpmClient bpmClient) {
	 	InputStream fileToBeUploaded = getClass().getResourceAsStream(TEST_FILE_NAME);
		
	 	BpmElement startable = TEST_UPLOAD_FILE_PROCESS.elementName("uploadFile(String,InputStream,String)");
		
	 	SubProcessCallResult result = bpmClient.start()
	 		        .subProcess(startable)
	 		        .execute(TEST_SFTP_NAME,fileToBeUploaded, TEST_FILE_NAME) // Callable sub process input arguments 
	 		        .subResult();
		
	 	Boolean isSuccess = result.param("isSuccess", Boolean.class);
	 	assertThat(isSuccess).isTrue();
	 }

	 @Test
	 @Order(3)
	 public void callUploadIvyFile(BpmClient bpmClient) throws IOException {
	 	InputStream fileToBeUploaded = getClass().getResourceAsStream(TEST_FILE_NAME);
	 	java.io.File javaFile = new java.io.File(TEST_FILE_NAME);
	 	FileUtils.copyInputStreamToFile(fileToBeUploaded, javaFile);
		
	 	File ivyFile = new File(TEST_FILE_NAME, true);
	 	FileUtils.moveFile(javaFile, ivyFile.getJavaFile());
		
	 	BpmElement startable = TEST_UPLOAD_FILE_PROCESS.elementName("uploadFile(String,File)");
		
	 	SubProcessCallResult result = bpmClient.start()
	 		        .subProcess(startable)
	 		        .execute(TEST_SFTP_NAME, ivyFile) // Callable sub process input arguments 
	 		        .subResult();
		
	 	Boolean isSuccess = result.param("isSuccess", Boolean.class);
	 	assertThat(isSuccess).isTrue();
	 }

	 @Test
	 @Order(4)
	 public void callListAllFiles(BpmClient bpmClient) {
	 	BpmElement startable = TEST_DOWNLOAD_FILE_PROCESS.elementName("listAllFiles(String,String)");
		
	 	SubProcessCallResult result = bpmClient.start()
	 		        .subProcess(startable)
	 		        .execute(TEST_SFTP_NAME, ".") // Callable sub process input arguments 
	 		        .subResult();
	 	List<FileData> listFiles = result.param("listFiles", List.class);
	 	assertThat(listFiles.size()).isGreaterThanOrEqualTo(1);
	 	assertThat(listFiles).anyMatch(f -> f.getName().equals(TEST_FILE_NAME));
	 }

	 @Test
	 @Order(5)
	 public void callDownloadFile(BpmClient bpmClient) {
	 	BpmElement startable = TEST_DOWNLOAD_FILE_PROCESS.elementName("downloadFile(String,String)");
		
	 	SubProcessCallResult result = bpmClient.start()
	 		        .subProcess(startable)
	 		        .execute(TEST_SFTP_NAME, TEST_FILE_NAME) // Callable sub process input arguments 
	 		        .subResult();
	 	java.io.File downloadedFile = result.param("toFile", java.io.File.class);
	 	assertThat(downloadedFile.length()).isEqualTo(TEST_FILE_SIZE);
	 	assertThat(downloadedFile.getName()).isEqualTo(TEST_FILE_NAME);
	 }
}
