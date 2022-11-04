$Username = 'admin'
$Password = 'P@ssw0rd'
$pass = ConvertTo-SecureString -AsPlainText $Password -Force

$SecureString = $pass
# Uses you password securly
$MySecureCreds = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $Username,$SecureString
$s = New-PSSession -ComputerName "192.168.2.120" -Credential $credential
Invoke-Command -Session $s -Command {c:\tmp\environmental.ps1}
#Invoke-Command -Session $s -Command {Get-ChildItem -Path C:\}
#Invoke-Command -Session $s -Command {netstat -an}


