param (
    [string]$FilePath = '',
    [string]$Destination = '' # This is used to set the specific location beyond the root path
 )

 if ($FilePath -eq '' -or $Destination -eq '')
 {
    Write-Host 'Usage: SFTPUpload_Auto.ps1 <FilePath> <SftpPath>'
    exit
 }

Import-Module Posh-SSH #Load the Posh-SSH module

#Set the credentials
$username = 'username'
$Password = ConvertTo-SecureString 'Password' -AsPlainText -Force
$Credential = New-Object System.Management.Automation.PSCredential ($username, $Password)

$SftpPath = "/Root/Path/$Destination"

#Set the IP of the SFTP server
$SftpIp = '10.0.0.1'

#Establish the SFTP connection
#New-SFTPSession -ComputerName $SftpIp -Credential $Credential
$session = New-SFTPSession -ComputerName $SftpIp -Credential $credential -AcceptKey

#Upload the file to the SFTP path
Set-SFTPFile -SessionId $session.SessionId -LocalFile $FilePath -RemotePath $SftpPath

#Disconnect SFTP session
(Get-SFTPSession -SessionId 0).Disconnect()