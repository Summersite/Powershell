cls
Get-ItemProperty HKLM:\software\WOW6432Node\Microsoft\windows\CurrentVersion\Uninstall\* | Select-Object Displayname, Displayversion, Publisher, InstallDate | Format-Table -AutoSize