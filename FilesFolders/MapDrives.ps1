# Maps network drives
New-PSDrive –Name “z” –PSProvider FileSystem –Root “\\192.168.2.101\External2TBUSB3” –Persist
New-PSDrive –Name “y” –PSProvider FileSystem –Root “\\192.168.2.101\External2TBUSB” –Persist
New-PSDrive –Name “x” –PSProvider FileSystem –Root “\\192.168.2.101\backup” –Persist

get-psdrive x, y, z | Remove-PSDrive

Remove-Item -“\\192.168.2.101\External2TBUSB3” "microsoft" -Force -Recurse

Remove-Item -Path “\\192.168.2.101\External2TBUSB3\microsoft\" -force -recurse

Remove-Item -Path z:\microsoft\ -force -recurse
