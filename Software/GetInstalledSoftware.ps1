Get-ItemProperty HKLM:\software\WOW6432Node\Microsoft\windows\CurrentVersion\Uninstall\* | Select-Object Displayname, Displayversion, Publisher, InstallDate | Format-Table -AutoSize

Get-ItemProperty HKLM:\software\WOW6432Node\Microsoft\windows\CurrentVersion\Uninstall\* | Select-Object Displayname, Displayversion, Publisher, InstallDate | Format-Table -AutoSize

#query remote computer 
Invoke-command -computer spectre  {Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | where {$_.displayname -notLike "*Update*" -and $_.displayname -notLike "*Office*" -and $_.displayname -notLike "*Hotfix*"} | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate | Sort-Object displayname -descending | Format-Table -AutoSize}

Invoke-command  {Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | where {$_.displayname -notLike "*Update*" -and $_.displayname -notLike "*Office*" -and $_.displayname -notLike "*Hotfix*"} | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate | Sort-Object displayname -descending | Format-Table -AutoSize}

Invoke-command  {Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | where {$_.displayname -notLike "*Update*" -and $_.displayname -notLike "*Office*"} | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate | Sort-Object displayname -descending | Format-Table -AutoSize}


# be low will get you installed software with display name including Microsoft
Invoke-command {Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | where {$_.displayname -Like "*Microsoft*"} | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate | Sort-Object displayname -descending | Format-Table -AutoSize} > c:\windows\temp\softwareinstalled.txt
 > .\desktop\Installedsoftware.txt

 Invoke-command  {Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | where {$_.displayname -Like "*Update*" -and $_.displayname -notLike "*Office*"} | Select-Object  DisplayName, DisplayVersion, Publisher, InstallDate | Sort-Object displayname -descending | Format-Table -AutoSize}

 Invoke-command {Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | where {$_.displayname -Like "*Microsoft*"} | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate | Sort-Object displayname -descending | Format-Table -AutoSize}