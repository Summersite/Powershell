get-eventlog -LogName System -entrytype error -Source sidebyside
get-help eventlog

GET-EVENTLOG -LOGNAME GOPRODESKTOPAPP

CLEAR-EVENTLOG -LOGNAME GOPRODESKTOPAPP -Confirm 
CLEAR-EVENTLOG -LOGNAME system -Confirm
Get-CimInstance win32_LoggedOnUser -