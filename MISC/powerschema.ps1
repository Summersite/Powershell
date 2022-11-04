Get-WinEvent -ProviderName Microsoft-Windows-Kernel-Power | Where-Object {$_.id -eq 42} | format-list
Get-WinEvent -ProviderName .\microsoft-windows-battery-events.dll | Where-Object {$_.id -eq 42} | format-list
Get-WinEvent -ProviderName Microsoft-Windows-Kernel-Power | Where-Object {$_.id -eq 524} | format-list
powercfg –restoredefaultschemes
powercfg /?
powercfg /REQUESTS /SLEEPSTUDY
powercfg /SLEEPSTUDY
powercfg -batteryreport
