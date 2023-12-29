#get specific software installed
Get-WmiObject -Class Win32_Product | where vendor -eq "DUO Security inc." | select Name, Version