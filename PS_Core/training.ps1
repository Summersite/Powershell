help get-service
help get-service -Full
help get-service -Online
get-process   | debug-process
get-hotfix | Select-Object Description,hotfixid | Format-List
get-hotfix | Select-Object Description,hotfixid | Format-List

suspend-service -name lanman* -whatif
get-service spooler | stop-service
get-service spooler | start-service
get-wmiobject win32_service -filter "name = 'blue*'"

# list of files in c:\windows -- sort decending --------------- select first 10   (can use the following -last)
# https://technet.microsoft.com/en-us/library/ee176955.aspx
Get-ChildItem c:\windows\*.* | Sort-Object length -descending | Select-Object -first 10

# https://technet.microsoft.com/en-us/library/ee176955.aspx
Get-Process | Select-Object name,id | Format-List | 
Get-Process | Select-Object name | Format-List
Get-Process | Select-Object *
Get-Process | Select-Object Name, StartTime | Format-List
Get-Process | Select-Object Name = "WINRM" | format-list
Get-Service | Select-Object name, starttime -Last 20 | format-list
Get-Service winrm | Format-List

# Using the Where-Object Cmdlet
# https://technet.microsoft.com/en-us/library/ee177028.aspx
Get-Process | Where-Object {$_.handles -gt 200 -or $_.name -eq "svchost"}
# Find WINRM
Get-Service | Where-Object { $_.name -eq "WINRM"}

# test for folder exists
https://technet.microsoft.com/en-us/library/ee177015.aspx
# working
Test-Path HKCU:\Software\Microsoft\Windows\CurrentVersion
Test-Path HKLM:\Software\Wow6432Node\Google\Update
Test-Path c:\Windows
# not working
Test-Path \\naep-dev-001\d$  
# working
Test-Path i:
