get-psdrive
Get-PSDrive -PSProvider FileSystem
Get-PSDrive -PSProvider FileSystem | Select-Object name, @{n="Root"; e={if ($_.DisplayRoot -eq $null) {$_.Root} else {$_.DisplayRoot}}}

( Get-ADComputer -Filter * ).Name | 
% { Invoke-Command -ComputerName $_ -ScriptBlock { Get-PSDrive -PSProvider FileSystem | 
        Select-Object name, @{n="Root"; e={if ($_.DisplayRoot -eq $null) {$_.Root} else {$_.DisplayRoot}}}
     }
 }


Get-WmiObject -Class Win32_MappedLogicalDisk | select Name, ProviderName