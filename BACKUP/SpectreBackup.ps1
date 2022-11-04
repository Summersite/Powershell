#Backup your data
# Logname should include hostname_Date 
# Set env variables
Set-ExecutionPolicy unrestricted -Scope CurrentUser -Force
$cred = Get-Credential -Credential 192.168.2.101\root

Invoke-Expression -Command W:\Dropbox\Development\powershellgit\Works\Browser\ChromeBookmarksByDate.ps1
write-host -ForegroundColor Yellow "Created chrome browser bookmarks backup and placed it in W:\Bookmarks\"

New-PSDrive -Name "S" -Root "\\192.168.2.101\backup" -Persist -PSProvider "FileSystem" -Credential $cred

$hostname= $env:computername
$date = Get-Date
$date = $date.ToString(“dd-MM-yyyy”)
$DestPath = '\\192.168.2.101\backup\Laptops'
$SourcePathDesktop = 'C:\Users\Admin\Desktop\'
$SourcePathData = 'W:\Dropbox\'
$SourcePathBookMarks = 'W:\Bookmarks\'
$logfilepath = '\\192.168.2.101\backup\Laptops\Logfiles\'
$logfile = "$logFilePath\$($hostname)_$date.log"


# Copy to central backup
Copy-Item  -PassThru $SourcepathDesktop $DestPath\$($hostname)\ -Force -Recurse > $logfile
Write-Host -ForegroundColor Green "I've just copied $SourcepathDesktop to $DestPath\$($hostname)\Desktop" >> $logfile
Copy-Item  -PassThru $SourcePathData $DestPath\$($hostname)\ -Force -Recurse >> $logfile
Write-Host -ForegroundColor Green "I've just copied $SourcePathData to $SourcePathDatap to $DestPath\$($hostname)\data" >> $logfile
Copy-Item  -PassThru $SourcePathBookMarks $DestPath\$($hostname)\ -Force -Recurse >> $logfile
Write-Host -ForegroundColor Green "I've just copied $SourcePathBookMarks to $DestPath\$($hostname)\bookmarks" >> $logfile

Start-Sleep -s 15