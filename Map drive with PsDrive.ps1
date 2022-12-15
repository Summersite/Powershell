# https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/new-psdrive?view=powershell-7.3
# Create new Mapped Drive connection
New-PSDrive -Persist -Name "X" -PSProvider "FileSystem" -Root "\\vhost01\f$" -Scope Global
