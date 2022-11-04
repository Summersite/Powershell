$FileName = (Get-Date).tostring(“dd-MM-yyyy”)
New-Item -itemType File -Path w:\logfiles\ -Name ($FileName + “.log”) -force