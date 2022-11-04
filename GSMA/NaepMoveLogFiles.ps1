$Souce = "C:\Windows\System32\winevt\Logs\Archive-*.*"
$Destination = "d:\ArchiveSystemlogs\Security"
if (!(Test-Path $Destination)) {New-Item -Path $Destination -ItemType Directory -Force}
$LogsSize = gci -Path $Souce | measure -Sum -Property Length | select -ExpandProperty Sum
$FreeSpace = get-wmiobject Win32_LogicalDisk -Filter "DeviceID = 'D:'" | select -ExpandProperty FreeSpace

if ($FreeSpace -gt $LogsSize) {
    Move-Item -Path $Souce -Destination $Destination -Force
} else {
    $SmtpClient = new-object system.net.mail.smtpClient
    $MailMessage = New-Object system.net.mail.mailmessage
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    [System.Net.ServicePointManager]::CheckCertificateRevocationList = $false;
    [System.Net.ServicePointManager]::ServerCertificateValidationCallback = $null

    $mailmessage.From = "NAEPIMS <noreply@naepims.org>"
    $SmtpClient.Host = "email-smtp.us-east-1.amazonaws.com"
    $SMTPClient.EnableSsl = $true
    $SMTPClient.Credentials = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList "AKIAVKJKWOUTPLZMBVGA", (ConvertTo-SecureString "BALt8cLm0Qi5gB+9rUl/a3Iq1AN3pqrtDdR355h88lvY" –asplaintext –force)
    $MailMessage.DeliveryNotificationOptions = ("onSuccess", "onFailure")
    $MailMessage.Priority = [System.Net.Mail.MailPriority]::Normal
    $mailmessage.To.add("NAEPSystemsTeam <NAEPSystemsTeam@FULCRUMIT.COM>")
    $mailmessage.Subject = "$env:COMPUTERNAME drive D: has insufficient free space to store event logs backups"
    $mailmessage.Body = "Free space: {0:f2}Gb, Log size: {1:f2}Gb" -f ($FreeSpace/1Gb), ($LogsSize/1Gb)
    $smtpclient.Send($mailmessage)
}