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
Se0 @StartSub f7 '' #zField
Se0 @EndSub f8 '' #zField
Se0 @GridStep f9 '' #zField
Se0 @PushWFArc f11 '' #zField
Se0 @PushWFArc f14 '' #zField
Se0 @PushWFArc f15 '' #zField
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
Se0 f3 actionCode 'import com.axonivy.connector.sftp.service.SftpClientService;
import java.io.FileOutputStream;



ivy.log.debug("The following file: {0} will be downloaded from the server.", in.remoteFileName);
	
in.toFile = new File(in.remoteFileName, true);

FileOutputStream fos = null;
try {
	fos = new FileOutputStream(in.toFile.getJavaFile());
	SftpClientService.getInstance().getSession().read(in.remoteFileName, fos);
}
catch(Exception e) {
	ivy.log.error("dowloadFile failed because of the following error: ", e);
}
finally {
	if(#fos is initialized) {
		fos.close();
	}
}
ivy.log.debug("File downloaded.");
' #txt
Se0 f3 @C|.xml '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<elementInfo>
    <language>
        <name>Download file</name>
    </language>
</elementInfo>
' #txt
Se0 f3 296 42 112 44 -35 -8 #rect
Se0 f2 408 64 593 64 #arcP
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
Se0 f9 actionCode 'import com.axonivy.connector.sftp.service.SftpClientService;


ivy.log.debug("The following directory: {0} will be listed.", in.remoteDirectory);
try {
	in.listFiles = SftpClientService.getInstance().listAllFiles(in.remoteDirectory);
}
catch(Exception e) {
	ivy.log.error("listAllFiles failed because of the following error: ", e);
}
' #txt
Se0 f9 @C|.xml '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<elementInfo>
    <language>
        <name>List All Files</name>
    </language>
</elementInfo>
' #txt
Se0 f9 296 234 112 44 -32 -8 #rect
Se0 f11 408 256 593 256 #arcP
Se0 f14 111 64 296 64 #arcP
Se0 f15 111 256 296 256 #arcP
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
Se0 f9 mainOut f11 tail #connect
Se0 f11 head f8 mainIn #connect
Se0 f0 mainOut f14 tail #connect
Se0 f14 head f3 mainIn #connect
Se0 f7 mainOut f15 tail #connect
Se0 f15 head f9 mainIn #connect
