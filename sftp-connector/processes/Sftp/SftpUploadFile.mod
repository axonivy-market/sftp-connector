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
Se0 @CallSub f7 '' #zField
Se0 @PushWFArc f8 '' #zField
Se0 @Alternative f9 '' #zField
Se0 @PushWFArc f10 '' #zField
Se0 @PushWFArc f4 '' #zField
Se0 @PushWFArc f11 '' #zField
Se0 @StartSub f12 '' #zField
Se0 @EndSub f13 '' #zField
Se0 @CallSub f14 '' #zField
Se0 @GridStep f15 '' #zField
Se0 @Alternative f16 '' #zField
Se0 @PushWFArc f17 '' #zField
Se0 @PushWFArc f18 '' #zField
Se0 @PushWFArc f19 '' #zField
Se0 @PushWFArc f20 '' #zField
Se0 @ErrorBoundaryEvent f21 '' #zField
Se0 @PushWFArc f22 '' #zField
Se0 @PushWFArc f23 '' #zField
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
Se0 f3 actionCode '
ivy.log.debug("The following file: {0} will be uploaded to the server. File size: {1} bytes", in.fileName, in.fileToBeUploaded.available());

in.sftpClient.uploadFile(in.fileToBeUploaded, in.fileName);

ivy.log.debug("File uploaded.");
in.isSuccess = true;
in.sftpClient.close();

ivy.log.debug("Connection closed.");
' #txt
Se0 f3 @C|.xml '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<elementInfo>
    <language>
        <name>Upload file</name>
    </language>
</elementInfo>
' #txt
Se0 f3 424 42 112 44 -27 -8 #rect
Se0 f2 536 64 593 64 #arcP
Se0 f5 actionTable 'out=in;
' #txt
Se0 f5 actionCode 'ivy.log.error("uploadFile failed because of to following error: ", error);
' #txt
Se0 f5 attachedToRef 17A24810A3595EC1-f3 #txt
Se0 f5 497 81 30 30 0 15 #rect
Se0 f6 512 111 601 77 #arcP
Se0 f6 1 512 128 #addKink
Se0 f6 2 576 128 #addKink
Se0 f6 1 0.5933249901889531 0 0 #arcLabel
Se0 f7 processCall Sftp/SftpHelper:openConnection() #txt
Se0 f7 requestActionDecl '<> param;' #txt
Se0 f7 responseMappingAction 'out=in;
out.sftpClient=result.#sftpClient;
' #txt
Se0 f7 @C|.xml '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<elementInfo>
    <language>
        <name>Connect</name>
    </language>
</elementInfo>
' #txt
Se0 f7 168 42 112 44 -22 -8 #rect
Se0 f8 111 64 168 64 #arcP
Se0 f9 336 48 32 32 0 16 #rect
Se0 f10 280 64 336 64 #arcP
Se0 f4 expr in #txt
Se0 f4 outCond 'in.#sftpClient is initialized' #txt
Se0 f4 368 64 424 64 #arcP
Se0 f11 352 80 608 79 #arcP
Se0 f11 1 352 160 #addKink
Se0 f11 2 608 160 #addKink
Se0 f11 1 0.501953125 0 0 #arcLabel
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
Se0 f14 processCall Sftp/SftpHelper:openConnection() #txt
Se0 f14 requestActionDecl '<> param;' #txt
Se0 f14 responseMappingAction 'out=in;
out.sftpClient=result.#sftpClient;
' #txt
Se0 f14 @C|.xml '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<elementInfo>
    <language>
        <name>Connect</name>
    </language>
</elementInfo>
' #txt
Se0 f14 168 234 112 44 -22 -8 #rect
Se0 f15 actionTable 'out=in;
' #txt
Se0 f15 actionCode 'import java.io.FileInputStream;

ivy.log.debug("The following file: {0} will be uploaded to the server.", in.ivyFile.getName());

in.sftpClient.uploadFile(new FileInputStream(in.ivyFile.getJavaFile()), in.ivyFile.getName());

ivy.log.debug("File uploaded.");
in.isSuccess = true;
in.sftpClient.close();

ivy.log.debug("Connection closed.");
' #txt
Se0 f15 @C|.xml '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<elementInfo>
    <language>
        <name>Upload file</name>
    </language>
</elementInfo>
' #txt
Se0 f15 424 234 112 44 -27 -8 #rect
Se0 f16 336 240 32 32 0 16 #rect
Se0 f17 111 256 168 256 #arcP
Se0 f18 280 256 336 256 #arcP
Se0 f19 expr in #txt
Se0 f19 outCond 'in.#sftpClient is initialized' #txt
Se0 f19 368 256 424 256 #arcP
Se0 f20 536 256 593 256 #arcP
Se0 f21 actionTable 'out=in;
' #txt
Se0 f21 actionCode 'ivy.log.error("uploadFile failed because of to following error: ", error);
' #txt
Se0 f21 attachedToRef 17A24810A3595EC1-f15 #txt
Se0 f21 497 273 30 30 0 15 #rect
Se0 f22 512 303 608 271 #arcP
Se0 f22 1 512 320 #addKink
Se0 f22 2 576 320 #addKink
Se0 f22 1 0.5301560500977818 0 0 #arcLabel
Se0 f23 expr in #txt
Se0 f23 352 272 608 271 #arcP
Se0 f23 1 352 352 #addKink
Se0 f23 2 608 352 #addKink
Se0 f23 1 0.501953125 0 0 #arcLabel
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
Se0 f0 mainOut f8 tail #connect
Se0 f8 head f7 mainIn #connect
Se0 f7 mainOut f10 tail #connect
Se0 f10 head f9 in #connect
Se0 f9 out f4 tail #connect
Se0 f4 head f3 mainIn #connect
Se0 f9 out f11 tail #connect
Se0 f11 head f1 mainIn #connect
Se0 f12 mainOut f17 tail #connect
Se0 f17 head f14 mainIn #connect
Se0 f14 mainOut f18 tail #connect
Se0 f18 head f16 in #connect
Se0 f16 out f19 tail #connect
Se0 f19 head f15 mainIn #connect
Se0 f15 mainOut f20 tail #connect
Se0 f20 head f13 mainIn #connect
Se0 f21 mainOut f22 tail #connect
Se0 f22 head f13 mainIn #connect
Se0 f16 out f23 tail #connect
Se0 f23 head f13 mainIn #connect
