# Backup your data
# Logname should include hostname_Date 
# Set env variables
$hostname= $env:computername
$LocalIP= (Test-Connection $hostname -Count 1).IPV4Address.IpAddressTostring
$ip= Get-NetIPAddress -CimSession $env:COMPUTERNAME -InterfaceAlias Wi-FI -AddressFamily IPv4 | select ipaddress
$chip= $env:PROCESSOR_ARCHITECTURE




$date = Get-Date
$date = $date.ToString(“dd-MM-yyyy”)
$DestPath = '\\192.168.2.101\backup\Laptops'
$SourcePathDesktop = 'C:\Users\Admin\Desktop\'
$SourcePathData = 'W:\Dropbox\Development\'
$SourcePathBookMarks = 'W:\Bookmarks\'
$logfilepath = '\\192.168.2.101\backup\Laptops\Logfiles\'
$logfile = "$logFilePath\$($hostname)_$date.log"

#   $Time
#   $BookMarks
# export Bookmarks
# Create bookmarks file
# copy to $sourcePath




Function LogWrite {
    Param ([string]$logstring)
    Add-Content $logfile -Value $logstring
}

#logwrite $hostname
#logwrite $chip
#logwrite $ip

# Copy to central backup
Copy-Item  -PassThru $SourcepathDesktop $DestPath\$($hostname)\desktop -Force -Recurse > $logfile
# logwrite "I've just copied $SourcepathDesktop to $DestPath\$($hostname)"
Write-Host -ForegroundColor Green "I've just copied $SourcepathDesktop to $DestPath\$($hostname)\Desktop" >> $logfile
Copy-Item  -PassThru $SourcePathData $DestPath\$($hostname) -Force -Recurse >> $logfile
Write-Host -ForegroundColor Green "I've just copied $SourcePathData to $SourcePathDatap to $DestPath\$($hostname)" >> $logfile
Copy-Item  -PassThru $SourcePathBookMarks $DestPath\$($hostname) -Force -Recurse >> $logfile
Write-Host -ForegroundColor Green "I've just copied $SourcePathBookMarks to $DestPath\$($hostname)" >> $logfile

Start-Sleep -s 30