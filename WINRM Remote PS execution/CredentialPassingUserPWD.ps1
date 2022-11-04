# This is the exact code used to connect to remote windows host and run powershell command

$username = "admin"
$password = ConvertTo-SecureString -String "P@ssw0rd" -AsPlainText -Force
$cred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $username, $password

$session_option = New-PSSessionOption -SkipCACheck -SkipCNCheck -SkipRevocationCheck
Invoke-Command -ComputerName 192.168.2.120 -UseSSL -ScriptBlock { netstat -an } -Credential $cred -SessionOption $session_option