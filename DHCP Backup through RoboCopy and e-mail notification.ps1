##Author: Mohammad Imran
#Date Written: 09/01/2018 
#Pupose : DHCP Backup through RoboCopy and e-mail notification.

# Backup Config:-
$SourceFolder = "C:\Windows\system32\dhcp"
$DestinationFolder = "\\10.0.0.12\backup\DHCPBackup\MWF"
$Logfile = "\\10.0.0.12\backup\DHCPBackup\MWFDHCPBackup.log"
$EmailFrom = "notification@saddaengineers.com"
$EmailTo = "admin@saddaengineers.com"
$EmailBody = "DHCP_Backup completed successfully. See attached log file for details"
$EmailSubject = "HO_DHCP_Backup(MWF)"
$SMTPServer = "10.0.0.11"
$SMTPPort = "25"

# Made Copy Folder with Robocopy
Robocopy $SourceFolder $DestinationFolder /E /ZB /R:1 /W:1 /PURGE /LOG:$Logfile /NP

# Send E-mail message with log file attachment
$Message = New-Object Net.Mail.MailMessage($EmailFrom, $EmailTo, $EmailSubject, $EmailBody)
$Attachment = New-Object Net.Mail.Attachment($Logfile, 'text/plain')
$Message.Attachments.Add($Attachment)
$SMTPClient = New-Object Net.Mail.SmtpClient($SmtpServer, $SMTPPort)
$SMTPClient.Send($Message)