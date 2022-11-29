Get-Command | where {$_.Source -like "Microsoft.PowerShell.*" } | sort Source | sort Version
