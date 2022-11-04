# https://docs.microsoft.com/en-us/powershell/windows/get-started?view=win10-ps

$PCInfo=$env:computername
$SystmeInfo=.\Desktop\"$env:computername"
cls
md .\Desktop\"$env:computername"Info
Get-NetIPConfiguration -Detailed >.\Desktop\"$env:computername"_NetIpConfiguration.txt
Get-NetAdapter >.\Desktop\"$env:computername"netadapter.txt
Get-NetAdapterBinding
Get-WmiObject win32_OperatingSystem
#Start-Sleep 5
#Get-Netadapter
#Get-NetIPConfiguration
