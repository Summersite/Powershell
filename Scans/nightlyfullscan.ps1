#Backup your data
# Logname should include hostname_Date 
# Set env variables
$hostname= $env:computername
$date = Get-Date
$date = $date.ToString(“dd-MM-yyyy”)
$logfilepath = '\\192.168.2.101\backup\Logs\scans\'
$logfile = "$logFilePath\Full Scan from $($hostname)_$date.log"

Set-ExecutionPolicy unrestricted -Scope CurrentUser -Force
Unblock-File \\192.168.2.101\backup\development\powershell\scans\NightlyScan.ps1
#$cred = Get-Credential -Credential 192.168.2.101\root
#Unblock-File \\192.168.2.101\backup\development\powershell\NightlyScan.ps1 -Verbose
#Invoke-Expression -Command \\192.168.2.101\backup\development\powershell\NightlyScan.ps1
write-host -ForegroundColor Yellow "Performing scan and creating logfile in \\192.168.2.101\backup\logs\scans"

nmap 192.168.2.0/24 -O >$logfile 

