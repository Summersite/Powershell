# start chrome
start-process -filepath "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
# Variable declared
$k = get-process chrome
# get process ID
Get-Process -InputObject $k
# kill notepad crome
start-sleep 5
Stop-Process -InputObject $k