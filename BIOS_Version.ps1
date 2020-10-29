$query = “Select * from Win32_Bios”
Get-WmiObject -Query $query
# this is a change