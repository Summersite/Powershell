
$remoteFilePath = '\\192.168.2.101\backup\Laptops\Spectre'
$SourcepathDesktop = 'C:\Users\Admin\Desktop\'
$SourcePathData = 'W:\Development\'
$logfilepath = 'W:\logfiles\'

Copy-Item  -PassThru $SourcepathDesktop $remoteFilePath -Force -Recurse
Write-Host -ForegroundColor Green "I've just copied $SourcepathDesktop to $remoteFilePath"

Copy-Item  -PassThru $SourcePathData $remoteFilePath -Force -Recurse
Write-Host -ForegroundColor Green "I've just copied $SourcePathData to $remoteFilePath"

