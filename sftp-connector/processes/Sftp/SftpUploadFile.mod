[Ivy]
17A24810A3595EC1 9.2.0 #module
>Proto >Proto Collection #zClass
Se0 SftpUploadFile Big #zClass
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
Se0 @StartSub f12 '' #zField
Se0 @EndSub f13 '' #zField
Se0 @GridStep f15 '' #zField
Se0 @PushWFArc f20 '' #zField
Se0 @ErrorBoundaryEvent f21 '' #zField
Se0 @PushWFArc f22 '' #zField
Se0 @PushWFArc f24 '' #zField
Se0 @PushWFArc f8 '' #zField
>Proto Se0 Se0 SftpUploadFile #zField
Se0 f0 inParamDecl '<java.io.InputStream fileToBeUploaded,String fileName> param;' #txt
Se0 f0 inParamTable 'out.fileName=param.fileName;
out.fileToBeUploaded=param.fileToBeUploaded;
' #txt
Se0 f0 outParamDecl '<Boolean isSuccess> result;' #txt
Se0 f0 outParamTable 'result.isSuccess=in.isSuccess;
' #txt
Se0 f0 callSignature uploadFile(java.io.InputStream,String) #txt
Se0 f0 tags CONNECTOR #txt
Se0 f0 @C|.xml '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<elementInfo>
    <language>
        <name>uploadFile(InputStream,String)</name>
    </language>
</elementInfo>
' #txt
Se0 f0 81 49 30 30 -61 20 #rect
Se0 f0 res:/cms/Images/Logo/16E7E3294211A884.png?small #fDecoratorIcon
Se0 f1 593 49 30 30 0 15 #rect
Se0 f3 actionTable 'out=in;
' #txt
Se0 f3 actionCode 'import com.axonivy.connector.sftp.service.SftpClientService;


ivy.log.debug("The following file: {0} will be uploaded to the server. File size: {1} bytes", 
	in.fileName, in.fileToBeUploaded.available());

SftpClientService.getInstance().getSession().write(in.fileToBeUploaded, in.fileName);

ivy.log.debug("File uploaded.");
in.isSuccess = true;
' #txt
Se0 f3 @C|.xml '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<elementInfo>
    <language>
        <name>Upload file</name>
    </language>
</elementInfo>
' #txt
Se0 f3 296 42 112 44 -27 -8 #rect
Se0 f2 408 64 593 64 #arcP
Se0 f5 actionTable 'out=in;
' #txt
Se0 f5 actionCode 'ivy.log.error("uploadFile failed because of the following error: ", error);
' #txt
Se0 f5 attachedToRef 17A24810A3595EC1-f3 #txt
Se0 f5 369 81 30 30 0 15 #rect
Se0 f6 384 111 608 79 #arcP
Se0 f6 1 384 128 #addKink
Se0 f6 2 576 128 #addKink
Se0 f6 1 0.5933249901889531 0 0 #arcLabel
Se0 f12 inParamDecl '<File file> param;' #txt
Se0 f12 inParamTable 'out.ivyFile=param.file;
' #txt
Se0 f12 outParamDecl '<Boolean isSuccess> result;' #txt
Se0 f12 outParamTable 'result.isSuccess=in.isSuccess;
' #txt
Se0 f12 callSignature uploadFile(File) #txt
Se0 f12 tags CONNECTOR #txt
Se0 f12 @C|.xml '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<elementInfo>
    <language>
        <name>uploadFile(File)</name>
    </language>
</elementInfo>
' #txt
Se0 f12 81 241 30 30 -31 17 #rect
Se0 f12 res:/cms/Images/Logo/16E7E3294211A884.png?small #fDecoratorIcon
Se0 f13 593 241 30 30 0 15 #rect
Se0 f15 actionTable 'out=in;
' #txt
Se0 f15 actionCode 'import com.axonivy.connector.sftp.service.SftpClientService;
import java.io.FileInputStream;

ivy.log.debug("The following file: {0} will be uploaded to the server.", in.ivyFile.getName());

SftpClientService.getInstance().getSession().write(new FileInputStream(in.ivyFile.getJavaFile()), in.ivyFile.getName());

ivy.log.debug("File uploaded.");
in.isSuccess = true;
' #txt
Se0 f15 @C|.xml '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<elementInfo>
    <language>
        <name>Upload file</name>
    </language>
</elementInfo>
' #txt
Se0 f15 296 234 112 44 -27 -8 #rect
Se0 f20 408 256 593 256 #arcP
Se0 f21 actionTable 'out=in;
' #txt
Se0 f21 actionCode 'ivy.log.error("uploadFile failed because of the following error: ", error);
' #txt
Se0 f21 attachedToRef 17A24810A3595EC1-f15 #txt
Se0 f21 369 273 30 30 0 15 #rect
Se0 f22 384 303 608 271 #arcP
Se0 f22 1 384 320 #addKink
Se0 f22 2 576 320 #addKink
Se0 f22 1 0.5301560500977818 0 0 #arcLabel
Se0 f24 111 64 296 64 #arcP
Se0 f8 111 256 296 256 #arcP
>Proto Se0 .type com.axonivy.connector.sftp.SftpUploadFileData #txt
>Proto Se0 .processKind CALLABLE_SUB #txt
>Proto Se0 .xml '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<elementInfo>
    <language>
        <swimlaneLabel>uploadFile</swimlaneLabel>
        <swimlaneLabel>uploadFile</swimlaneLabel>
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
Se0 f15 mainOut f20 tail #connect
Se0 f20 head f13 mainIn #connect
Se0 f21 mainOut f22 tail #connect
Se0 f22 head f13 mainIn #connect
Se0 f0 mainOut f24 tail #connect
Se0 f24 head f3 mainIn #connect
Se0 f12 mainOut f8 tail #connect
Se0 f8 head f15 mainIn #connect
