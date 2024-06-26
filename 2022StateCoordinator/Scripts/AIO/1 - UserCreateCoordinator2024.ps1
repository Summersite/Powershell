﻿# *** Used to create local users for AIO Dell 2022 ***
# https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.localaccounts/set-localuser?view=powershell-5.1
# -AccountExpires
# -AccountNeverExpires
# -Confirm Prompts you for confirmation before running the cmdlet.
# -Description
# -FullName
# -InputObject
# -Name
# -Password
# -PasswordNeverExpires
# -SID
# -UserMayChangePassword
# -WhatIf
# 


Set-ExecutionPolicy -ExecutionPolicy unrestricted -Scope CurrentUser -Force
# ***************************** Create Naepadmin user *******************************************
$sec_pass = ConvertTo-SecureString -String "JoinTheCongoLine2021!" -AsPlainText -Force
New-LocalUser -Name NAEPAdmin -FullName "NAEP Administrator" -Description "NAEP Administrator for this unit." -PasswordNeverExpires -Password $sec_pass
Add-LocalGroupMember -Group Administrators -Member NAEPAdmin

# ***************************** Change Administrator Pwd ****************************************
Write-host "Reset Administrator password":
$sec_passAdministrator = ConvertTo-SecureString -String "F1lthy%M0ney" -AsPlainText -Force
$Adminuseraccount = get-localuser -Name "administrator"
$Adminuseraccount | Set-LocalUser -passwordneverexpires $true -Password $sec_passAdministrator 
Enable-LocalUser -name $Adminuseraccount

# ***************************** Create State Coordinator User ***********************************
$sec_passCoordinator = ConvertTo-SecureString -String "LongDaysSummerBreeze2023##" -AsPlainText -Force
New-LocalUser -Name NSC-AR -FullName "State Coordinator" -Description "NAEP StateCoordinator for this unit." -PasswordNeverExpires -Password $sec_passCoordinator
Add-LocalGroupMember -Group users -Member NSC-AR #NSC-State

# ***************************** Rename Computer *************************************************
$NewHostName = Read-Host "Input new hostname in this format SCLT2024-XX "  #SCLT2023-State
Rename-Computer $NewHostName
shutdown /r /f