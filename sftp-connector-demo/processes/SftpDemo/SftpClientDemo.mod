[Ivy]
17A249499B6E47FF 9.2.0 #module
>Proto >Proto Collection #zClass
Te0 SftpClientDemo Big #zClass
Te0 B #cInfo
Te0 #process
Te0 @AnnotationInP-0n ai ai #zField
Te0 @TextInP .type .type #zField
Te0 @TextInP .processKind .processKind #zField
Te0 @TextInP .xml .xml #zField
Te0 @TextInP .responsibility .responsibility #zField
Te0 @StartRequest f0 '' #zField
Te0 @EndTask f1 '' #zField
Te0 @UserDialog f3 '' #zField
Te0 @PushWFArc f4 '' #zField
Te0 @PushWFArc f2 '' #zField
>Proto Te0 Te0 SftpClientDemo #zField
Te0 f0 outLink start.ivp #txt
Te0 f0 inParamDecl '<> param;' #txt
Te0 f0 requestEnabled true #txt
Te0 f0 triggerEnabled false #txt
Te0 f0 callSignature start() #txt
Te0 f0 caseData businessCase.attach=true #txt
Te0 f0 @C|.xml '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<elementInfo>
    <language>
        <name>start.ivp</name>
    </language>
</elementInfo>
' #txt
Te0 f0 @C|.responsibility Everybody #txt
Te0 f0 81 49 30 30 -21 17 #rect
Te0 f1 337 49 30 30 0 15 #rect
Te0 f3 dialogId com.axonivy.connector.sftp.demo.SftpClientDemo #txt
Te0 f3 startMethod start() #txt
Te0 f3 requestActionDecl '<> param;' #txt
Te0 f3 responseMappingAction 'out=in;
' #txt
Te0 f3 @C|.xml '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<elementInfo>
    <language>
        <name>SftpClientDemo</name>
    </language>
</elementInfo>
' #txt
Te0 f3 168 42 112 44 -41 -8 #rect
Te0 f4 111 64 168 64 #arcP
Te0 f2 280 64 337 64 #arcP
>Proto Te0 .type com.axonivy.connector.sftp.demo.SftpClientDemoData #txt
>Proto Te0 .processKind NORMAL #txt
>Proto Te0 0 0 32 24 18 0 #rect
>Proto Te0 @|BIcon #fIcon
Te0 f0 mainOut f4 tail #connect
Te0 f4 head f3 mainIn #connect
Te0 f3 mainOut f2 tail #connect
Te0 f2 head f1 mainIn #connect
