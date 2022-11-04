Set-ExecutionPolicy -ExecutionPolicy unrestricted -Scope CurrentUser -Force
# ************************ Reset local adminstrator password and activate account ************************
Write-host "Reset Administrator password":
$Adminpassword = read-host -assecurestring
$Adminuseraccount = get-localuser -Name "administrator"
$Adminuseraccount | Set-LocalUser -passwordneverexpires $true -Password $Adminpassword
Enable-LocalUser -name $Adminuseraccount
# ************************************* Create State Coordinator *****************************************
$state = Read-Host "Enter the state name" -MaskInput #NSC-
$coordinator = Read-Host "Enter the coordinator name" #-MaskInput   the coordinator name
New-LocalUser $state -FullName $state -Description $coordinator # just ignore the pop up box asking for MaskInput
Add-LocalGroupMember -Group "Users" -Member $state
# Get-LocalUser -Name $state
$Password = Read-Host -AsSecureString
$UserAccount = Get-LocalUser -Name $state
$UserAccount | Set-LocalUser -Password $Password -PasswordNeverExpires:$true
