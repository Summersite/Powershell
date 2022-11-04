#$FileName = (Get-Date).tostring(“dd-MM-yyyy”)
#New-Item -itemType File -Path w:\logfiles\ -Name ($FileName + “.log”) -force

##Set env variables
$hostname= $env:computername
$LocalIP= (Test-Connection $hostname -Count 1).IPV4Address.IpAddressTostring
$chip= $env:PROCESSOR_ARCHITECTURE

#Setup Log for appending
$date = Get-Date
$date = $date.ToString("yyyyMMdd")
$LogPath = "w:\logfiles"
$logfile = "$logPath\$($hostname)_$date.log" #that $($variableName) format is a special way of specifying the variable within a string so that it knows it is its own variable
#https://www.itprotoday.com/powershell/variable-expansion-powershell-expressions
$ip= Get-NetIPAddress -CimSession $env:COMPUTERNAME -InterfaceAlias Wi-FI -AddressFamily IPv4 | select ipaddress

Function LogWrite {
    Param ([string]$logstring)
    Add-Content $logfile -Value $logstring
}

logwrite $hostname
logwrite $chip
logwrite $ip