﻿Remove-LocalUser -Name "admin"
Set-ExecutionPolicy -ExecutionPolicy unrestricted -Scope CurrentUser -Force
#Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Force
$Password = read-host -AsSecureString #Testing2020@@
New-LocalUser "admin" -Password $Password -FullName "ADMIN" -Description "This is the ADMIN user" 
Add-LocalGroupMember -Group "Administrators" -Member "admin"