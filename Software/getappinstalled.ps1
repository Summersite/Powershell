Set-ExecutionPolicy unrestricted -Force
# timestamp with AM PM format
filter timestamp {"$(get-date -format G): $_"}
Write-Output "Current Time" | timestamp >> d:\test\installed_Apps.txt

filter timestamp {"$(get-date): $_"}

Write-Output "Current Time" | timestamp > D:\test\updateversion.txt 
 
Get-WmiObject win32_product | Where-Object {$_.name -like "gopro"} >> D:\test\updateversion.txt

#install 
e:\Deploy\Scripts\eNAEPReleases\6.0.19.2749\FulcrumMDTScripts\FirmwareUpdater.ps1 -firmwarefolder E:\Deploy\Scripts\eNAEPReleases\6.0.19.2749\FulcrumMDTScripts\Firmware

#Uninstall 
e:\Deploy\Scripts\eNAEPReleases\6.0.19.2749\FulcrumMDTScripts\FirmwareUninstall.ps1 -firmwarefolder E:\Deploy\Scripts\eNAEPReleases\6.0.19.2749\FulcrumMDTScripts\Firmware


 
# get installed apps by name and with 24 hour time format
filter timestamp {"$(get-date): $_"}
Write-Output "Current Time" | timestamp >> d:\test\installed_Apps.txt 
Get-WmiObject win32_product | Where-Object {$_.name -like "*goo"} >> d:\test\installed_Apps.txt
