#-- Setup output file

$date = Get-Date

$date = $date.ToString("yyyyMMdd")

$LogPath = "W:\logfiles"

$logfile = "$logPath\$($hostname)_$date.log" #that $($variableName) format is a special way of specifying the variable within a string so that it knows it is its own variable



#-- Write out the hostname

$hostname= $env:computername | Out-File $logFile



#-- Get software from WMI

Write-Host "  -- Collecting Software from WMI (takes a bit)..."

#-- PowerShell < v7

#$allsw = Get-WMIObject -Query "SELECT * FROM Win32_Product"

#-- PowerShell v7+

$allsw = Get-CimInstance -Class Win32_Product | Select-Object Name,Version,Vendor,InstallDate | Format-Table –AutoSize | Out-File $logfile -Encoding Utf8 -Width 1024 -Append



#-- Get software from registry

Write-Host "  -- Collecting Software from the Registry..."

$allsw1 = Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate | Format-Table –AutoSize | Out-File $logfile -Encoding Utf8 -Width 1024 -Append



Write-Host "Software Inventory Completed: $logfile"