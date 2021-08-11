# SFTP Connector

[![CI Build](https://github.com/axonivy-market/sftp-connector/actions/workflows/ci.yml/badge.svg)](https://github.com/axonivy-market/sftp-connector/actions/workflows/ci.yml)

**SFTP Connector** is an SFTP client which uses the SFTP protocol to transfer files securely to and from a remote computer.
SFTP Connector is based on JSch [http://www.jcraft.com/jsch/] to handle the SFTP Connections and Operations.
JSch is a pure Java implementation of SSH2.
JSch allows you to connect to an sshd server and use port forwarding, X11 forwarding, file transfer, etc., and you can integrate its functionality into your own Java programs. JSch is licensed under BSD style license.

## Operations

1. Upload File

   Path: Sftp/SftpUploadFile -> uploadFile(fileToBeUploaded, filename)

   Description: this operation will upload the file to the root path on the server.

   Parameters: 

               - fileToBeUploaded -> the file to upload as java.io.InputStream

               - filename -> the file name as String

2. Download File

   Path: Sftp/SftpDownloadFile -> downloadFile(remoteFileName) Result: toFile

   Description: this operation will download the file from the server.

   Parameters: 

               - remoteFileName -> the file name as String

   Result: 

               - toFile -> the File to download as java.io.File

## Setup

   Open the `Configuration/variables.yaml` in your Designer and update the following global variables:

   ```
   
   Variables:

     com.axonivy.connector.sftp.server:
       # The host name to the SFTP server
       host: 'localhost'

       # The password to the SFTP server
       password: pwd

       # The port number to the SFTP server
       port: 22

       # The username to the SFTP server
       username: 'usr'

   ```

### Prerequisites:

* Working **SFTP Server**.
* You will also need the correct Server host name and the port number.
