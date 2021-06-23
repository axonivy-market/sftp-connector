[Ivy]
17A2EED74B988533 9.2.0 #module
>Proto >Proto Collection #zClass
Sr0 SftpHelper Big #zClass
Sr0 B #cInfo
Sr0 #process
Sr0 @AnnotationInP-0n ai ai #zField
Sr0 @TextInP .type .type #zField
Sr0 @TextInP .processKind .processKind #zField
Sr0 @TextInP .xml .xml #zField
Sr0 @TextInP .responsibility .responsibility #zField
Sr0 @StartSub f0 '' #zField
Sr0 @EndSub f1 '' #zField
Sr0 @GridStep f3 '' #zField
Sr0 @PushWFArc f4 '' #zField
Sr0 @PushWFArc f2 '' #zField
Sr0 @ErrorBoundaryEvent f5 '' #zField
Sr0 @PushWFArc f6 '' #zField
>Proto Sr0 Sr0 SftpHelper #zField
Sr0 f0 inParamDecl '<> param;' #txt
Sr0 f0 outParamDecl '<com.axonivy.connector.sftp.service.SftpClientService sftpClient> result;' #txt
Sr0 f0 outParamTable 'result.sftpClient=in.#sftpClient;
' #txt
Sr0 f0 callSignature openConnection() #txt
Sr0 f0 @C|.xml '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<elementInfo>
    <language>
        <name>openConnection()</name>
    </language>
</elementInfo>
' #txt
Sr0 f0 81 49 30 30 -40 16 #rect
Sr0 f1 337 49 30 30 0 15 #rect
Sr0 f3 actionTable 'out=in;
' #txt
Sr0 f3 actionCode 'import com.axonivy.connector.sftp.service.SftpClientService;
import java.lang.NumberFormatException;


String host = ivy.var.com_axonivy_connector_sftp_serverHost;
Integer port = 22;
try {
	port = Integer.parseInt(ivy.var.com_axonivy_connector_sftp_serverPort);
}
catch(NumberFormatException nfe) {
	ivy.log.error("The Global Variable: com_axonivy_connector_sftp_serverPort = {0} does not contain a number. The default port number: {1} will be used instead.", 
		nfe, ivy.var.com_axonivy_connector_sftp_serverPort, port);
}
String username = ivy.var.com_axonivy_connector_sftp_serverUsername;
String password = ivy.var.com_axonivy_connector_sftp_serverPassword;

ivy.log.debug("The following settings will be used to connect to the SFTP server: hostname: {0}, port: {1}, username: {2}. Connection in progress...", 
	host, port, username);

in.sftpClient = new SftpClientService(host, port, username, password);

ivy.log.debug("Connection established.");
' #txt
Sr0 f3 @C|.xml '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<elementInfo>
    <language>
        <name>Connect</name>
    </language>
</elementInfo>
' #txt
Sr0 f3 168 42 112 44 -22 -8 #rect
Sr0 f4 111 64 168 64 #arcP
Sr0 f2 280 64 337 64 #arcP
Sr0 f5 actionTable 'out=in;
' #txt
Sr0 f5 actionCode 'ivy.log.error("Connection cannot be open.", error);
' #txt
Sr0 f5 attachedToRef 17A2EED74B988533-f3 #txt
Sr0 f5 241 81 30 30 0 15 #rect
Sr0 f6 256 111 352 79 #arcP
Sr0 f6 1 256 128 #addKink
Sr0 f6 2 352 128 #addKink
Sr0 f6 1 0.4856858380418765 0 0 #arcLabel
>Proto Sr0 .type com.axonivy.connector.sftp.SftpHelperData #txt
>Proto Sr0 .processKind CALLABLE_SUB #txt
>Proto Sr0 .xml '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<elementInfo>
    <language>
        <swimlaneLabel>openConnection</swimlaneLabel>
    </language>
    <swimlaneOrientation>false</swimlaneOrientation>
    <swimlaneSize>192</swimlaneSize>
    <swimlaneColor gradient="false">-3342337</swimlaneColor>
    <swimlaneType>LANE</swimlaneType>
    <swimlaneSpaceBefore>0</swimlaneSpaceBefore>
</elementInfo>
' #txt
>Proto Sr0 0 0 32 24 18 0 #rect
>Proto Sr0 @|BIcon #fIcon
Sr0 f0 mainOut f4 tail #connect
Sr0 f4 head f3 mainIn #connect
Sr0 f3 mainOut f2 tail #connect
Sr0 f2 head f1 mainIn #connect
Sr0 f5 mainOut f6 tail #connect
Sr0 f6 head f1 mainIn #connect
