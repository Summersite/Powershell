Get-Command
Get-Command *process*
get-help Wait-Process
get-help Wait-Process -examples

get-help stop-Process -examples

# start notepad
notepad
# Variable declared
$p = get-process notepad
# get process ID
Get-Process -InputObject $p
# kill notepad process
Stop-Process -InputObject $p

$t = get-process TeamViewer_Service
Get-Process -InputObject $t
# kill notepad process
Stop-Process -InputObject $t

$d = get-process DropboxUpdate
Get-Process -InputObject $d
# kill notepad process
Stop-Process -InputObject $d

calc
$c = Get-Process -Name calculator
Get-Process -InputObject $c
Stop-Process -InputObject $c
Get-Process | Where-Object {$_.HasExited}

DropboxUpdate
$c = get-process chrome
stop-Process -Id $c.id

get-Process -Id $c.id
Wait-Process -Name "notepad"
Get-Process -InputObject $p

Stop-Process -Id $p

#Below needs tuning
#Write-eventlog
#get-help get-eventlog
