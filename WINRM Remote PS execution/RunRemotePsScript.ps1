$Username = '.\admin'
$Password = 'P@ssw0rd'
$pass = ConvertTo-SecureString -AsPlainText $Password -Force

$SecureString = $pass
# Users you password securly
$MySecureCreds = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $Username,$SecureString 

# Invoke-Command -ComputerName 192.168.2.120 'gwmi win32_service –credential $MySecureCreds –computer PC#'
Invoke-Command -ComputerName 192.168.2.120 -ScriptBlock { Get-ChildItem C:\ } $MySecureCreds