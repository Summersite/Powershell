# examples of pulling information from event logs (event viewer)
# ------- Example 1: Get event logs on the local computer -------
Get-EventLog -List
#Example 2: Get recent entries from an event log on the local computer
Get-EventLog -LogName System -Newest 5
#Example 3: Find all sources for a specific number of entries in an event log
 $Events = Get-EventLog -LogName System -Newest 1000
 $Events | Group-Object -Property Source -NoElement | Sort-Object -Property Count -Descending
 #---- Example 4: Get error events from a specific event log ----
Get-EventLog -LogName System -EntryType Error
#Example 5: Get events from an event log with an InstanceId and Source value
Get-EventLog -LogName System -InstanceId 10016 -Source DCOM
#-------- Example 6: Get events from multiple computers --------
Get-EventLog -LogName System -ComputerName Server01, Server02, Server03
#Example 7: Get all events that include a specific word in the message
Get-EventLog -LogName System -Message *description*
# ------ Example 8: Display the property values of an event ------
$A = Get-EventLog -LogName System -Newest 1
$A | Select-Object -Property *
# Example 9: Get events from an event log using a source and event ID
Get-EventLog -LogName Application -Source Outlook | Where-Object {$_.EventID -eq 63} | Select-Object -Property Source, EventID, InstanceId, Message
# -------- Example 10: Get events and group by a property --------
Get-EventLog -LogName System -UserName NT* | Group-Object -Property UserName -NoElement | Select-Object -Property Count, Name
#Example 11: Get events that occurred during a specific date and time range
$Begin = Get-Date -Date '1/17/2019 08:00:00'
$End = Get-Date -Date '1/17/2019 17:00:00'
Get-EventLog -LogName System -EntryType Error -After $Begin -Before $End
