Powershell.exe –ExecutionPolicy Bypass –file '\\192.168.2.101\backup\Development\PowerShell\WINRM Remote PS execution\runremoteshellcommand.ps1'
set-executionpolicy -scope CurrentUser -ExecutionPolicy Unrestricted -Force
unblock-file '\\192.168.2.101\backup\Development\PowerShell\WINRM Remote PS execution\runremoteshellcommand.ps1'
$password = ConvertTo-SecureString 'P@ssw0rd' -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential ('admin', $password)
#Invoke-Command -ComputerName 192.168.2.120 -ScriptBlock { Get-ChildItem C:\ } $credential
Invoke-Command -ComputerName 192.168.2.120 -ScriptBlock { Get-ChildItem C:\ } -credential $credential