#Axon Efeus **SFTP Anschluss** hilft du zu beschleunigen verarbeiten mal
Automatisierung Initiativen integrieren befestigen Datei Versetzung hinein eure
Arbeitsgang Arbeit. Mit dies SFTP Kunde kannst sicher du übertragen fest Dateien
zu und von einem entlegenen Computer. Dieser Anschluss:

* Benutzt das SFTP Protokoll
* Ist gegründet weiter [JSch](http://www.jcraft.com/jsch/) zu bedienen das SFTP
  Zusammenhänge und Operationen
* Ist #ein #pur #Java Ausführung von SSH2
* Erlaubt du zu koppeln zu ein sshd Server und benutzen #backbordseitig
  Nachsendung, X11 Nachsendung, feilen übertragen, #usw.
* Macht ihm leicht zu integrieren befestigen Datei Versetzung hinein eure
  Arbeitsgang Arbeit

## Demo

1. Klicken weiter **Feilen zu #Hochladen** und auswählen #man feilt von eurem
   lokalen Telefonbuch.

   ![#Hochladen-Feilen](images/Upload-File.png)

   Pfad: Sftp/SftpUploadFile -> uploadFile(fileToBeUploaded, filename)

   Steckbrief: Diese Operation will die Datei zu den Wurz Pfad #hochladen auf
   dem Server.

   Parameter:

               - fileToBeUploaded -> the file to upload as java.io.InputStream

               - filename -> the file name as String


2. Klicken weiter **Erfrischen** zu listen alle die Dateien auf dem entlegenen
   Telefonbuch.

   - Auswählen #man feilt von der Liste und klicken weiter **Lädt herunter/Ladet
     herunter**.

   ![Laden herunter-Feilen](images/Download-File.png)

   Pfad: Sftp/SftpDownloadFile -> downloadFile(remoteFileName) Resultieren:
   toFile

   Steckbrief: Diese Operation wollen die Datei von dem Server herunterladen.

   Parameter:

               - remoteFileName -> the file name as String

   Resultat:

               - toFile -> the File to download as java.io.File

Das **SftpClientDemo** #HTML Zwiegespräch zügelt alle zu #hochladen die
endgültigen Operationen, listet und ladet herunter die Datei von/zu die SFTP
Server.

![SftpClientDemo](images/SftpClientDemo.png)

## Einrichtung

Vor starten die Demo, bitte machen sicher zu haben eine SCHT/SFTP Server auf
eurem Computer (jeweilig den Computer mögen du zugreifen). Für testen, das
freilassen [Rebex Winzig SFTP Server](https://www.rebex.net/tiny-sftp-server/)
ist weiterempfohlen.
1. Öffnen herein die folgenden Lagen “RebexTinySftpServer.exe.config” Mit einen
   Text Chefredakteur und verbessern die folgenden Werte:
   ![RebexTinySftpServer.exe.config](images/RebexTinySftpServer.exe.config.png)

   \* #Um zu #testen den Anschluss mit SCHT wesentliches Paar, leg den
   öffentlichen Schlüssel Datei zu Ordner `c:/sshkey`.

2. Konfigurier eins oder More SFTP Anschlüsse in global Variablen. Ein SFTP
   Anschluss ist identifiziert #bei einem Namen und eine globale Variable
   Sektion zügelnd #zugreifen Auskunft. Das folgende Beispiel Vorstellungen
   Zusammenhang Auskunft für eine SFTP Anschluss sollte jener sein erreichbar
   unter die Name Einheimische-rebex. Leg diesen variablen Block hinein eure
   Projekt. Mindestens `bringen unter`, `auth`, `Benutzername` und `Passwort`
   muss sein definiert.
   ```

   Variables:

     com.axonivy.connector.sftp.server:
       local-rebex:
         # The host name to the SFTP server
         host: 'localhost'

         # Auth type to the SFPT server: password OR ssh
         auth: 'password'

         # The password to the SFTP server
         password: pwd

         # The port number to the SFTP server
         port: 22

         # The username to the SFTP server
         username: 'usr'

   ```

   Oder #um zu aktivieren den Anschluss mit SCHT keypair, `Geheimnis.sshkey` Und
   `Geheimnis.sshpassphrase` Müssen sein definiert:
   ```

   Variables:

     com.axonivy.connector.sftp.server:
       local-rebex:
         # The host name to the SFTP server
         host: 'localhost'

         # Auth type to the SFPT server: password OR ssh
         auth: 'ssh'

         # The password to the SFTP server
         password: ''

         # The port number to the SFTP server
         port: 22

         # The username to the SFTP server
         username: 'usr'

         # The path of ssh key file to SFTP server
         sshkeyFilePath: 'path/to/file'

         # The ssh key passphrase
         sshPassphraseSecret: 'Your ssh key passphrase'
   ```
   \* Der persönliche Schlüssel ist in paaren von dem öffentlichen Schlüssel
   gelegt #im gleichen Schritt und Tritt 1

3. Speicher die #abgeändert Lagen.

### Voraussetzungen:

* Arbeitend **SFTP Server**.
* Du willst auch brauchen das berichtigen Server Gastgeber Namen und die
  #backbordseitig Nummer.
