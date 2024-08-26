Axon Ivy's **SFTP Connector** helps you to accelerate process automation initiatives by integrating secure file transfer into your process work. With this SFTP client you can easily transfer files securely to and from a remote computer. This connector:

* uses the SFTP protocol
* is based on [JSch](http://www.jcraft.com/jsch/) to handle the SFTP Connections and Operations
* is a pure Java implementation of SSH2
* allows you to connect to an sshd server and use port forwarding, X11 forwarding, file transfer, etc.
* makes it easy to integrate secure file transfer into your process work


## Demo

1. Click on **File to Upload** and select one file from your local directory.

   ![Upload-File](images/Upload-File.png)

   Path: Sftp/SftpUploadFile -> uploadFile(fileToBeUploaded, filename)

   Description: this operation will upload the file to the root path on the server.

   Parameters: 

               - fileToBeUploaded -> the file to upload as java.io.InputStream

               - filename -> the file name as String


2. Click on **Refresh** to list all the files on the remote directory.

   - Select one file from the list and click on **Download**.

   ![Download-File](images/Download-File.png)

   Path: Sftp/SftpDownloadFile -> downloadFile(remoteFileName) Result: toFile

   Description: this operation will download the file from the server.

   Parameters: 

               - remoteFileName -> the file name as String

   Result: 

               - toFile -> the File to download as java.io.File

The **SftpClientDemo** HTML Dialog contains all the final operations to upload, list and download the file from/to the SFTP Server.

   ![SftpClientDemo](images/SftpClientDemo.png)

## Setup

Before starting the demo, please make sure to have an SSH/SFTP server on your computer (respective the computer you want to access). For testing, the free
 [Rebex Tiny SFTP Server](https://www.rebex.net/tiny-sftp-server/) is recommended.
1. Open the following settings in “RebexTinySftpServer.exe.config” with a text editor and update the following values:
   ![RebexTinySftpServer.exe.config](images/RebexTinySftpServer.exe.config.png)

   \* In order to test the connector with SSH key pair, put the public key file to folder `c:/sshkey`. 

2. Configure one or more SFTP connectors in global variables. A SFTP connector is identified by a name and a global variable section containing access information. The following example shows connection information for a SFTP connector that should be accessible under the name local-rebex.
Put this variable block into your project. At least `host`, `auth`, `username` and `password` must be defined.
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

   Or in order to enable the connector with SSH keypair, `secret.sshkey` and `secret.sshpassphrase` must be defined:
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
       
              # Dear Bug Hunter
              # This credential is intentionally included for educational purposes only and does not provide access to any production systems
              # Please do not submit it as part of our bug bounty program
         # The path of ssh key file to SFTP server
         sshkeyFilePath: 'path/to/file'
  
         # The ssh key passphrase
         sshPassphraseSecret: 'Your ssh key passphrase'
   ```
   \* the private key is in pair of the public key put in step 1

3. Save the changed settings.


### Prerequisites:

* Working **SFTP Server**.
* You will also need the correct Server host name and the port number.
