##Set env variables
$hostname= $env:computername
$LocalIP= (Test-Connection $hostname -Count 1).IPV4Address.IpAddressTostring
$chip= $env:PROCESSOR_ARCHITECTURE

#Setup Log for appending
$date = Get-Date
$date = $date.ToString("yyyyMMdd")
$logfile = "w:\logfiles\test_$date.log" 
$ip= Get-NetIPAddress -CimSession $env:COMPUTERNAME -InterfaceAlias Wi-FI -AddressFamily IPv4 | select ipaddress

Function LogWrite {
    Param ([string]$logstring)
    Add-Content $logfile -Value $logstring
}

logwrite $hostname
logwrite $chip
logwrite $ip