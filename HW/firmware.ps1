if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }


write-host "Hardware Versions"
gwmi win32_bios

write-host "Driver Versions"
gwmi win32_pnpsigneddriver | where {$_.deviceclass -eq "Firmware"} | select devicename,driverversion | ft
