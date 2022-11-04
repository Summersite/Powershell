Get-WmiObject -Query "Select Name FROM WIN32_UserAccount" | format-table Name
