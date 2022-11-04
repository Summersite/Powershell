##################################################################################################
# Get Services, Installed Software including Windows                                                               #
# Filename - Tablet Information                                                                  #
##################################################################################################
##################################################################################################
##################################################################################################
# Author:  Jimmy Johannsen                                                                       #
# Date: 02/17/2017                                                                               #
##################################################################################################
  
#$OutputDrive=G:
#$outputPath=.\output
New-Item -Name c:\output\ -ItemType directory
Get-Service | Select-Object Status, Name, DisplayName | ConvertTo-Html | Out-File w:\Services.htm
Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |  Select-Object DisplayName, DisplayVersion, Publisher, InstallDate  | ConvertTo-Html | Out-File w:\AppsInstalled.htm
Get-WmiObject -Class Win32_Bios | ConvertTo-Html | Out-File w:\BIOS.htm 

#write-host "Hardware Versions"
#Get-WmiObject win32_bios | ConvertTo-Html | Out-File g:\Bios.htm

#write-host "Driver Versions"
#Get-WmiObject win32_pnpsigneddriver | where {$_.deviceclass -eq "Firmware"} | select devicename,driverversion | ft | ConvertTo-Html | Out-File g:\Bios.htm

#Get-WmiObject win32_bios | Select-Object -Property smbiosbiosversion | ConvertTo-Html | Out-File g:\Bios.htm