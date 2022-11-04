#https://www.howtogeek.com/165293/how-to-get-a-list-of-software-installed-on-your-pc-with-a-single-command/
Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate | Format-Table –AutoSize

# get all installed software 
Get-WmiObject -Class Win32_Product

# https://www.codetwo.com/admins-blog/how-to-check-installed-software-version/
# get by vendor name
Get-WmiObject -Class Win32_Product | where vendor -eq Tortoisesvn | select Name, Version

# This should get products installed form remote pc
Get-WmiObject Win32_Product -ComputerName hp6450b -Credential admin | select Name,Version

# this will query event manager for last installed programs
Get-WinEvent -ProviderName msiinstaller | where id -eq 1033 | select timecreated,message | FL *
