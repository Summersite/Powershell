Invoke-Command -ComputerName 192.168.2.120 -ScriptBlock { COMMAND } -credential USERNAME
Invoke-Command -ComputerName 192.168.2.120 -ScriptBlock { Get-ChildItem C:\ } -credential admin 