$date = Get-Date
$date = $date.ToString("yyyyMMddhhmm")
$hostName = $env:COMPUTERNAME
$logfile = "\\TRUENAS\106data\backup\Laptops\NAEPIMS-WORK\logs\fileCopyLog_$($hostName)_$($date).txt"
if(!(test-path $logFile)){
    New-Item $logFile
}
#######################
#$sourcePath = "W:\picture\"
#$destPath = "W:\destination\"

$sourcePath = "C:\Users\jimmy\Desktop\"
$destPath = "\\TRUENAS\106data\backup\Laptops\NAEPIMS-WORK\Desktop"

Add-Content -Path $logFile -Value "COMMENCING BACKUP from $sourcePath to $destPath "


#robocopy $sourcePath $destPath /COPYALL /B /SEC /E /DCOPY:T /XO /R:0 /W:0 /LOG+:$logFile

robocopy $sourcePath $destPath /MIR /FFT /Z /XA:H /W:5 /LOG+:$logFile