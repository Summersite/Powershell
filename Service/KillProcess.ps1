#Magnify
$p = Get-Process -Name "Magnify"
Stop-Process -InputObject $p
Get-Process | Where-Object {$_.HasExited}