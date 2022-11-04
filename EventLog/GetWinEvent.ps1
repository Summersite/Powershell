Get-WinEvent -ProviderName Microsoft-Windows-Kernel-Power | Where-Object {$_.id -eq 42} | format-list
Get-WinEvent -ProviderName Microsoft-Windows-Kernel-Power | Where-Object {$_.id -eq 10016} | format-list
