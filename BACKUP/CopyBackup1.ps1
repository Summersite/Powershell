#copy data from Spectre to Freenas
# Set-ExecutionPolicy unrestricted -Force
$remoteFilePath = '\\192.168.2.101\backup\Laptops\Spectre'
$SourcepathDesktop = 'C:\Users\Admin\Desktop\'
$SourcePathData = 'W:\Development\'
$copiedFileDataDesktop = Copy-Item -Path $SourcepathDesktop -Destination $remoteFilePath -Recurse
$copiedFileDataPath = Copy-Item -Path $SourcePathData -Destination $remoteFilePath -Recurse
Write-Host "I've just copied $SourcepathDesktop to $remoteFilePath"
Write-Host "I've just copied $SourcePathData to $remoteFilePath"