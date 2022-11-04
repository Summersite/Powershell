Get-WmiObject -Query "Select Name FROM CIM_NetworkAdapter" | format-table Name
