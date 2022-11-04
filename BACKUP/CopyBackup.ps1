#copy data from Spectre to Freenas
$remoteFilePath = '\\192.168.2.101\backup\Laptops\Spectre'
$Sourcepath = 'C:\Users\Admin\Desktop\'
$copiedFile = Copy-Item -Path $Sourcepath -Destination $remoteFilePath -Recurse
Write-Host "I've just copied $Sourcepath to $remoteFilePath"