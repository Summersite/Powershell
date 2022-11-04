#https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-eventlog?view=powershell-5.1


# getting the latest number of events from system sorted highest to lowest 
$Events = Get-EventLog -LogName System -Newest 50
$Events | Group-Object -Property Source -NoElement | Sort-Object -Property Count -Descending

# show entrytype error
Get-EventLog -LogName System -EntryType Error

# shows specific instance id from system event log
Get-EventLog -LogName System -InstanceId 10016 -Source DCOM

# show from eventlog wich includes "description" in the message field
Get-EventLog -LogName System -Message *description*

#retrieve the newest event 
$A = Get-EventLog -LogName System -Newest 10
$A | Select-Object -Property *

# get specific eventid 
Get-EventLog -LogName Application -Source Outlook | Where-Object {$_.EventID -eq 63} |
Select-Object -Property Source, EventID, InstanceId, Message

#show events by username
Get-EventLog -LogName System -UserName NT* | Group-Object -Property UserName -NoElement |
Select-Object -Property Count, Name

# get evnts within specific time
$Begin = Get-Date -Date '8/17/2020 08:00:00'
$End = Get-Date -Date '8/20/2020 17:00:00'
Get-EventLog -LogName System -EntryType Error -After $Begin -Before $End

$Begin = Get-Date -Date '1/17/2020 08:00:00'
$End = Get-Date -Date '8/20/2020 17:00:00'
Get-EventLog -LogName Application -Source Outlook -After $Begin -Before $End | Where-Object {$_.EventID -eq 63} |
Select-Object -Property Source, EventID, InstanceId, Message