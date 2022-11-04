cls

systeminfo | find /i "Boot Time" | Write-Host -ForegroundColor Yellow

"********************************************************************"

net statistics workstation | Write-Host -ForegroundColor Cyan

"********************************************************************"

"List of Boot Times" | Write-Host -ForegroundColor yellow
Get-EventLog -LogName System | where { ($_.InstanceId -bAnd 0xFFFF) -eq 6006 }
Pause