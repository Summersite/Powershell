Set-ExecutionPolicy unrestricted -Force
filter timestamp {"$(get-date -format G): $_"}


filter timestamp {"$(get-date): $_"}

Write-Output "Current Time" | timestamp >> c:\temp\updateversion.txt 
 
Get-WmiObject win32_product | Where-Object {$_.name -like "*surfacepro*"} >> c:\temp\updateversion.txt

#install 
e:\Deploy\Scripts\eNAEPReleases\6.0.19.2749\FulcrumMDTScripts\FirmwareUpdater.ps1 -firmwarefolder E:\Deploy\Scripts\eNAEPReleases\6.0.19.2749\FulcrumMDTScripts\Firmware

#Uninstall 
e:\Deploy\Scripts\eNAEPReleases\6.0.19.2749\FulcrumMDTScripts\FirmwareUninstall.ps1 -firmwarefolder E:\Deploy\Scripts\eNAEPReleases\6.0.19.2749\FulcrumMDTScripts\Firmware
