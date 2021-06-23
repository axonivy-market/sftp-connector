[Ivy]
17A2497EC43FFF44 9.2.0 #module
>Proto >Proto Collection #zClass
Ts0 SftpClientDemoProcess Big #zClass
Ts0 RD #cInfo
Ts0 #process
Ts0 @TextInP .type .type #zField
Ts0 @TextInP .processKind .processKind #zField
Ts0 @AnnotationInP-0n ai ai #zField
Ts0 @MessageFlowInP-0n messageIn messageIn #zField
Ts0 @MessageFlowOutP-0n messageOut messageOut #zField
Ts0 @TextInP .xml .xml #zField
Ts0 @TextInP .responsibility .responsibility #zField
Ts0 @UdInit f0 '' #zField
Ts0 @UdProcessEnd f1 '' #zField
Ts0 @GridStep f9 '' #zField
Ts0 @PushWFArc f10 '' #zField
Ts0 @PushWFArc f2 '' #zField
Ts0 @UdMethod f11 '' #zField
Ts0 @UdProcessEnd f12 '' #zField
Ts0 @CallSub f38 '' #zField
Ts0 @PushWFArc f14 '' #zField
Ts0 @UdProcessEnd f4 '' #zField
Ts0 @CallSub f5 '' #zField
Ts0 @GridStep f8 '' #zField
Ts0 @PushWFArc f7 '' #zField
Ts0 @PushWFArc f15 '' #zField
Ts0 @UdEvent f16 '' #zField
Ts0 @UdProcessEnd f17 '' #zField
Ts0 @CallSub f18 '' #zField
Ts0 @PushWFArc f19 '' #zField
Ts0 @UdMethod f21 '' #zField
Ts0 @PushWFArc f22 '' #zField
Ts0 @GridStep f3 '' #zField
Ts0 @PushWFArc f6 '' #zField
Ts0 @PushWFArc f20 '' #zField
Ts0 @GridStep f23 '' #zField
Ts0 @PushWFArc f24 '' #zField
Ts0 @PushWFArc f13 '' #zField
>Proto Ts0 Ts0 SftpClientDemoProcess #zField
Ts0 f0 guid 162B91B419062D1B #txt
Ts0 f0 method start() #txt
Ts0 f0 inParameterDecl '<> param;' #txt
Ts0 f0 outParameterDecl '<> result;' #txt
Ts0 f0 @C|.xml '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<elementInfo>
    <language>
        <name>start()</name>
    </language>
</elementInfo>
' #txt
Ts0 f0 115 51 26 26 -16 15 #rect
Ts0 f1 371 51 26 26 0 12 #rect
Ts0 f9 actionTable 'out=in;
' #txt
Ts0 f9 actionCode '
in.clientHost = ivy.var.com_axonivy_connector_sftp_serverHost;
in.clientPort = Integer.parseInt(ivy.var.com_axonivy_connector_sftp_serverPort);
in.clientUsername = ivy.var.com_axonivy_connector_sftp_serverUsername;
in.clientPassword = ivy.var.com_axonivy_connector_sftp_serverPassword;
' #txt
Ts0 f9 @C|.xml '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<elementInfo>
    <language>
        <name>Init</name>
        <nameStyle>4,7
</nameStyle>
    </language>
</elementInfo>
' #txt
Ts0 f9 200 42 112 44 -8 -8 #rect
Ts0 f10 expr out #txt
Ts0 f10 141 64 200 64 #arcP
Ts0 f2 expr out #txt
Ts0 f2 312 64 371 64 #arcP
Ts0 f11 guid 162BA2B9BF7640CB #txt
Ts0 f11 method handleFileUpload(org.primefaces.event.FileUploadEvent) #txt
Ts0 f11 inParameterDecl '<org.primefaces.event.FileUploadEvent event> param;' #txt
Ts0 f11 inParameterMapAction 'out.uploadedFile=param.event.getFile();
' #txt
Ts0 f11 outParameterDecl '<> result;' #txt
Ts0 f11 @C|.xml '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<elementInfo>
    <language>
        <name>handleFileUpload
(FileUploadEvent)</name>
        <nameStyle>34,5,7
</nameStyle>
    </language>
</elementInfo>
' #txt
Ts0 f11 115 147 26 26 -49 15 #rect
Ts0 f12 659 147 26 26 0 12 #rect
Ts0 f38 processCall Sftp/SftpUploadFile:uploadFile(java.io.InputStream,String) #txt
Ts0 f38 requestActionDecl '<java.io.InputStream fileToBeUploaded,String fileName> param;' #txt
Ts0 f38 requestMappingAction 'param.fileToBeUploaded=in.uploadedFile.getInputstream();
param.fileName=in.uploadedFile.getFileName();
' #txt
Ts0 f38 responseMappingAction 'out=in;
out.isFileUploaded=result.isSuccess;
' #txt
Ts0 f38 @C|.xml '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<elementInfo>
    <language>
        <name>Sftp/SftpUploadFile</name>
    </language>
</elementInfo>
' #txt
Ts0 f38 264 138 112 44 -51 -8 #rect
Ts0 f14 141 160 264 160 #arcP
Ts0 f4 659 243 26 26 0 12 #rect
Ts0 f5 processCall Sftp/SftpDownloadFile:downloadFile(String) #txt
Ts0 f5 requestActionDecl '<String remoteFileName> param;' #txt
Ts0 f5 requestMappingAction 'param.remoteFileName=in.fileToDownload.name;
' #txt
Ts0 f5 responseMappingAction 'out=in;
out.toFile=result.#toFile;
' #txt
Ts0 f5 @C|.xml '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<elementInfo>
    <language>
        <name>Sftp/SftpDownloadFile</name>
    </language>
</elementInfo>
' #txt
Ts0 f5 264 234 128 44 -59 -8 #rect
Ts0 f8 actionTable 'out=in;
' #txt
Ts0 f8 actionCode 'import javax.faces.application.FacesMessage;
import javax.faces.context.FacesContext;
import java.io.FileInputStream;
import org.primefaces.model.DefaultStreamedContent;


if(in.#toFile is initialized && in.toFile.exists()) {
	in.streamedContent = new DefaultStreamedContent(new FileInputStream(in.toFile), "", in.toFile.getName(), in.toFile.length());
}
else {
	FacesContext.getCurrentInstance().addMessage(":mainPanel:downloadForm:downloadMessages", 
		new FacesMessage(FacesMessage.SEVERITY_ERROR, "Error", "The file: ''" + in.remoteFileName + "'' does not exist on the server!"));
}
' #txt
Ts0 f8 @C|.xml '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<elementInfo>
    <language>
        <name>Build &#13;
Streamed Content</name>
    </language>
</elementInfo>
' #txt
Ts0 f8 456 234 128 44 -44 -16 #rect
Ts0 f7 584 256 659 256 #arcP
Ts0 f15 392 256 456 256 #arcP
Ts0 f16 guid 17A242DACB13DDD2 #txt
Ts0 f16 actionTable 'out=in;
' #txt
Ts0 f16 @C|.xml '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<elementInfo>
    <language>
        <name>listAllFiles</name>
    </language>
</elementInfo>
' #txt
Ts0 f16 115 339 26 26 -15 15 #rect
Ts0 f17 659 339 26 26 0 12 #rect
Ts0 f18 processCall Sftp/SftpDownloadFile:listAllFiles(String) #txt
Ts0 f18 requestActionDecl '<String remoteDirectory> param;' #txt
Ts0 f18 requestMappingAction 'param.remoteDirectory=".";
' #txt
Ts0 f18 responseMappingAction 'out=in;
out.listRemoteFiles=result.listFiles;
' #txt
Ts0 f18 @C|.xml '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<elementInfo>
    <language>
        <name>call list All Files</name>
    </language>
</elementInfo>
' #txt
Ts0 f18 264 330 112 44 -40 -8 #rect
Ts0 f19 141 352 264 352 #arcP
Ts0 f21 guid 17A243054FCBCE01 #txt
Ts0 f21 method downloadFile(com.axonivy.connector.sftp.service.SftpClientService.FileData) #txt
Ts0 f21 inParameterDecl '<com.axonivy.connector.sftp.service.SftpClientService.FileData file> param;' #txt
Ts0 f21 inParameterMapAction 'out.fileToDownload=param.file;
' #txt
Ts0 f21 outParameterDecl '<org.primefaces.model.StreamedContent streamedContent> result;' #txt
Ts0 f21 outParameterMapAction 'result.streamedContent=in.streamedContent;
' #txt
Ts0 f21 @C|.xml '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<elementInfo>
    <language>
        <name>downloadFile(FileData)</name>
    </language>
</elementInfo>
' #txt
Ts0 f21 115 243 26 26 -53 15 #rect
Ts0 f22 141 256 264 256 #arcP
Ts0 f3 actionTable 'out=in;
' #txt
Ts0 f3 actionCode 'import com.axonivy.connector.sftp.service.SftpClientService.FileData;
import java.util.ArrayList;


List listFilesOnly = new ArrayList();
for(FileData file: in.listRemoteFiles) {
	if(file.file) {
		listFilesOnly.add(file);
	}
}

in.listRemoteFiles = listFilesOnly;
' #txt
Ts0 f3 @C|.xml '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<elementInfo>
    <language>
        <name>Filter files only</name>
    </language>
</elementInfo>
' #txt
Ts0 f3 456 330 112 44 -38 -8 #rect
Ts0 f6 376 352 456 352 #arcP
Ts0 f20 568 352 659 352 #arcP
Ts0 f23 actionTable 'out=in;
' #txt
Ts0 f23 actionCode 'import javax.faces.application.FacesMessage;
import javax.faces.context.FacesContext;


if(in.isFileUploaded) {
	FacesContext.getCurrentInstance().addMessage(":mainPanel:uploadForm:uploadMessages", 
		new FacesMessage(FacesMessage.SEVERITY_INFO, "Info", "The file: ''" + in.uploadedFile.getFileName() + "'' is uploaded to the server."));
}
else {
	FacesContext.getCurrentInstance().addMessage(":mainPanel:uploadForm:uploadMessages", 
		new FacesMessage(FacesMessage.SEVERITY_ERROR, "Error", "The file: ''" + in.uploadedFile.getFileName() + "'' is not uploaded to the server!"));
}
' #txt
Ts0 f23 @C|.xml '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<elementInfo>
    <language>
        <name>Add &#13;
Faces Message</name>
    </language>
</elementInfo>
' #txt
Ts0 f23 456 138 128 44 -41 -16 #rect
Ts0 f24 376 160 456 160 #arcP
Ts0 f13 584 160 659 160 #arcP
>Proto Ts0 .type com.axonivy.connector.sftp.demo.SftpClientDemo.SftpClientDemoData #txt
>Proto Ts0 .processKind HTML_DIALOG #txt
>Proto Ts0 -8 -8 16 16 16 26 #rect
Ts0 f0 mainOut f10 tail #connect
Ts0 f10 head f9 mainIn #connect
Ts0 f9 mainOut f2 tail #connect
Ts0 f2 head f1 mainIn #connect
Ts0 f11 mainOut f14 tail #connect
Ts0 f14 head f38 mainIn #connect
Ts0 f5 mainOut f15 tail #connect
Ts0 f15 head f8 mainIn #connect
Ts0 f8 mainOut f7 tail #connect
Ts0 f7 head f4 mainIn #connect
Ts0 f16 mainOut f19 tail #connect
Ts0 f19 head f18 mainIn #connect
Ts0 f21 mainOut f22 tail #connect
Ts0 f22 head f5 mainIn #connect
Ts0 f18 mainOut f6 tail #connect
Ts0 f6 head f3 mainIn #connect
Ts0 f3 mainOut f20 tail #connect
Ts0 f20 head f17 mainIn #connect
Ts0 f38 mainOut f24 tail #connect
Ts0 f24 head f23 mainIn #connect
Ts0 f23 mainOut f13 tail #connect
Ts0 f13 head f12 mainIn #connect
