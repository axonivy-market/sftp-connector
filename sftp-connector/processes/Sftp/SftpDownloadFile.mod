[Ivy]
17A24807C6359438 9.2.0 #module
>Proto >Proto Collection #zClass
Se0 SftpDownloadFile Big #zClass
Se0 B #cInfo
Se0 #process
Se0 @AnnotationInP-0n ai ai #zField
Se0 @TextInP .type .type #zField
Se0 @TextInP .processKind .processKind #zField
Se0 @TextInP .xml .xml #zField
Se0 @TextInP .responsibility .responsibility #zField
Se0 @StartSub f0 '' #zField
Se0 @EndSub f1 '' #zField
Se0 @GridStep f3 '' #zField
Se0 @PushWFArc f2 '' #zField
Se0 @ErrorBoundaryEvent f5 '' #zField
Se0 @PushWFArc f6 '' #zField
Se0 @StartSub f7 '' #zField
Se0 @EndSub f8 '' #zField
Se0 @GridStep f9 '' #zField
Se0 @PushWFArc f11 '' #zField
Se0 @ErrorBoundaryEvent f12 '' #zField
Se0 @PushWFArc f13 '' #zField
Se0 @CallSub f19 '' #zField
Se0 @PushWFArc f20 '' #zField
Se0 @Alternative f23 '' #zField
Se0 @PushWFArc f24 '' #zField
Se0 @PushWFArc f4 '' #zField
Se0 @PushWFArc f25 '' #zField
Se0 @CallSub f26 '' #zField
Se0 @PushWFArc f27 '' #zField
Se0 @Alternative f28 '' #zField
Se0 @PushWFArc f29 '' #zField
Se0 @PushWFArc f10 '' #zField
Se0 @PushWFArc f30 '' #zField
>Proto Se0 Se0 SftpDownloadFile #zField
Se0 f0 inParamDecl '<String remoteFileName> param;' #txt
Se0 f0 inParamTable 'out.remoteFileName=param.remoteFileName;
' #txt
Se0 f0 outParamDecl '<java.io.File toFile> result;' #txt
Se0 f0 outParamTable 'result.toFile=in.#toFile.getJavaFile();
' #txt
Se0 f0 callSignature downloadFile(String) #txt
Se0 f0 tags CONNECTOR #txt
Se0 f0 @C|.xml '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<elementInfo>
    <language>
        <name>downloadFile(String)</name>
    </language>
</elementInfo>
' #txt
Se0 f0 81 49 30 30 -45 20 #rect
Se0 f0 res:/cms/Images/Logo/16E7E3294211A884.png?small #fDecoratorIcon
Se0 f1 593 49 30 30 0 15 #rect
Se0 f3 actionTable 'out=in;
' #txt
Se0 f3 actionCode 'import com.axonivy.connector.sftp.service.SftpClientService.FileData;
import java.io.FileOutputStream;


FileData fileData = in.sftpClient.getFileData(in.remoteFileName);
if(fileData.isFile()) {
	ivy.log.debug("The following file: {0} will be downloaded from the server. Size: {1} bytes", in.remoteFileName, fileData.size);
	
	in.toFile = new File(in.remoteFileName, true);

	FileOutputStream fos = null;
	try {
		fos = new FileOutputStream(in.toFile.getJavaFile());
		in.sftpClient.downloadFile(in.remoteFileName, fos);
	}
	finally {
		if(#fos is initialized) {
			fos.close();
		}
	}
	ivy.log.debug("File downloaded.");
}
else {
	ivy.log.error("The file: {0} does not exist on the server!", in.remoteFileName);
}
in.sftpClient.close();

ivy.log.debug("Connection closed.");
' #txt
Se0 f3 @C|.xml '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<elementInfo>
    <language>
        <name>Download file</name>
    </language>
</elementInfo>
' #txt
Se0 f3 424 42 112 44 -35 -8 #rect
Se0 f2 536 64 593 64 #arcP
Se0 f5 actionTable 'out=in;
' #txt
Se0 f5 actionCode 'ivy.log.error("dowloadFile failed because of to following error: ", error);
' #txt
Se0 f5 attachedToRef 17A24807C6359438-f3 #txt
Se0 f5 497 81 30 30 0 15 #rect
Se0 f6 512 111 601 77 #arcP
Se0 f6 1 512 128 #addKink
Se0 f6 2 576 128 #addKink
Se0 f6 1 0.4856858380418765 0 0 #arcLabel
Se0 f7 inParamDecl '<String remoteDirectory> param;' #txt
Se0 f7 inParamTable 'out.remoteDirectory=param.remoteDirectory;
' #txt
Se0 f7 outParamDecl '<java.util.List<com.axonivy.connector.sftp.service.SftpClientService.FileData> listFiles> result;' #txt
Se0 f7 outParamTable 'result.listFiles=in.listFiles;
' #txt
Se0 f7 callSignature listAllFiles(String) #txt
Se0 f7 tags CONNECTOR #txt
Se0 f7 @C|.xml '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<elementInfo>
    <language>
        <name>listAllFiles(String)</name>
    </language>
</elementInfo>
' #txt
Se0 f7 81 241 30 30 -38 18 #rect
Se0 f7 res:/cms/Images/Logo/16E7E3294211A884.png?small #fDecoratorIcon
Se0 f8 593 241 30 30 0 15 #rect
Se0 f9 actionTable 'out=in;
' #txt
Se0 f9 actionCode '
ivy.log.debug("The following directory: {0} will be listed.", in.remoteDirectory);

in.listFiles = in.sftpClient.getFileDataList(in.remoteDirectory);

in.sftpClient.close();

ivy.log.debug("Connection closed.");
' #txt
Se0 f9 @C|.xml '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<elementInfo>
    <language>
        <name>List All Files</name>
    </language>
</elementInfo>
' #txt
Se0 f9 424 234 112 44 -32 -8 #rect
Se0 f11 536 256 593 256 #arcP
Se0 f12 actionTable 'out=in;
' #txt
Se0 f12 actionCode 'ivy.log.error("listAllFiles failed because of to following error: ", error);
' #txt
Se0 f12 attachedToRef 17A24807C6359438-f9 #txt
Se0 f12 497 273 30 30 0 15 #rect
Se0 f13 512 303 601 269 #arcP
Se0 f13 1 512 320 #addKink
Se0 f13 2 576 320 #addKink
Se0 f13 1 0.4856858380418765 0 0 #arcLabel
Se0 f19 processCall Sftp/SftpHelper:openConnection() #txt
Se0 f19 requestActionDecl '<> param;' #txt
Se0 f19 responseMappingAction 'out=in;
out.sftpClient=result.#sftpClient;
' #txt
Se0 f19 @C|.xml '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<elementInfo>
    <language>
        <name>Connect</name>
    </language>
</elementInfo>
' #txt
Se0 f19 168 42 112 44 -22 -8 #rect
Se0 f20 111 64 168 64 #arcP
Se0 f23 336 48 32 32 0 16 #rect
Se0 f24 280 64 336 64 #arcP
Se0 f4 expr in #txt
Se0 f4 outCond 'in.#sftpClient is initialized' #txt
Se0 f4 368 64 424 64 #arcP
Se0 f25 352 80 608 79 #arcP
Se0 f25 1 352 160 #addKink
Se0 f25 2 608 160 #addKink
Se0 f25 1 0.501953125 0 0 #arcLabel
Se0 f26 processCall Sftp/SftpHelper:openConnection() #txt
Se0 f26 requestActionDecl '<> param;' #txt
Se0 f26 responseMappingAction 'out=in;
out.sftpClient=result.#sftpClient;
' #txt
Se0 f26 @C|.xml '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<elementInfo>
    <language>
        <name>Connect</name>
    </language>
</elementInfo>
' #txt
Se0 f26 168 234 112 44 -22 -8 #rect
Se0 f27 111 256 168 256 #arcP
Se0 f28 336 240 32 32 0 16 #rect
Se0 f29 280 256 336 256 #arcP
Se0 f10 expr in #txt
Se0 f10 outCond 'in.#sftpClient is initialized' #txt
Se0 f10 368 256 424 256 #arcP
Se0 f30 352 272 608 271 #arcP
Se0 f30 1 352 344 #addKink
Se0 f30 2 608 344 #addKink
Se0 f30 1 0.501953125 0 0 #arcLabel
>Proto Se0 .type com.axonivy.connector.sftp.SftpDownloadFileData #txt
>Proto Se0 .processKind CALLABLE_SUB #txt
>Proto Se0 .xml '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<elementInfo>
    <language>
        <swimlaneLabel>downloadFile</swimlaneLabel>
        <swimlaneLabel>listAllFiles</swimlaneLabel>
    </language>
    <swimlaneOrientation>false</swimlaneOrientation>
    <swimlaneSize>192</swimlaneSize>
    <swimlaneSize>192</swimlaneSize>
    <swimlaneColor gradient="false">-3342337</swimlaneColor>
    <swimlaneColor gradient="false">-3355393</swimlaneColor>
    <swimlaneType>LANE</swimlaneType>
    <swimlaneType>LANE</swimlaneType>
    <swimlaneSpaceBefore>0</swimlaneSpaceBefore>
    <swimlaneSpaceBefore>0</swimlaneSpaceBefore>
</elementInfo>
' #txt
>Proto Se0 0 0 32 24 18 0 #rect
>Proto Se0 @|BIcon #fIcon
Se0 f3 mainOut f2 tail #connect
Se0 f2 head f1 mainIn #connect
Se0 f5 mainOut f6 tail #connect
Se0 f6 head f1 mainIn #connect
Se0 f9 mainOut f11 tail #connect
Se0 f11 head f8 mainIn #connect
Se0 f12 mainOut f13 tail #connect
Se0 f13 head f8 mainIn #connect
Se0 f0 mainOut f20 tail #connect
Se0 f20 head f19 mainIn #connect
Se0 f19 mainOut f24 tail #connect
Se0 f24 head f23 in #connect
Se0 f23 out f4 tail #connect
Se0 f4 head f3 mainIn #connect
Se0 f23 out f25 tail #connect
Se0 f25 head f1 mainIn #connect
Se0 f7 mainOut f27 tail #connect
Se0 f27 head f26 mainIn #connect
Se0 f26 mainOut f29 tail #connect
Se0 f29 head f28 in #connect
Se0 f28 out f10 tail #connect
Se0 f10 head f9 mainIn #connect
Se0 f28 out f30 tail #connect
Se0 f30 head f8 mainIn #connect
