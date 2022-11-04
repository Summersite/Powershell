$PasswordNAEPAdmin = read-host -AsSecureString #@tlAnt1s
New-LocalUser "NAEPAdmin" -Password $PasswordNAEPAdmin -FullName "NAEPAdmin" -Description "This is the NAEPAdmin user" 
Add-LocalGroupMember -Group "Administrators" -Member "NAEPAdmin"
$useraccountNAEPAdmin = get-localuser -Name "NAEPAdmin"
$useraccountNAEPAdmin | Set-LocalUser -passwordneverexpires $true -AccountNeverExpires -UserMayChangePassword $false
Write-Host "NAEPAdmin was created"
Read-Host -Prompt "Press any key to continue"
Get-LocalUser -Name "NAEPAdmin"

# Remove-LocalUser -Name "NAEPAdmin"
# JoinTheCongoLine2021!

# Long$Days#Summer@Breeze35
Read-Host -Prompt "next get ready to set password for NSC-XX"

$PasswordNSCXX = read-host -AsSecureString #@tlAnt1s
New-LocalUser "NSC-XX" -Password $PasswordNSCXX -FullName "NSC-XX" -Description "This is the NSC-XX user" 
# Add-LocalGroupMember -Group "Administrators" -Member "NAEPAdmin"
$useraccountNSCXX = get-localuser -Name "NSC-XX"
$useraccountNSCXX | Set-LocalUser -passwordneverexpires $true -AccountNeverExpires -UserMayChangePassword $false
Write-Host "NSC-XX was created"
Read-Host -Prompt "Press any key to continue"
Get-LocalUser -Name "NSC-XX"

$newpwd = Read-Host "Enter the new password" -AsSecureString #testing
$newpwd = ConvertTo-SecureString -String "P@ssw0rd" -AsPlainText –Force
$useraccountBuildinAdministrator = get-localuser -Name "Administrator"
$useraccountBuildinAdministrator | Set-LocalUser -Password 



$Secure_String_NAEPAdmin_Pwd = ConvertTo-SecureString "JoinTheCongoLine2021!" -AsPlainText -Force
$Secure_String_NAEPAdmin_Pwd = ConvertFrom-SecureString -SecureString $Secure_String_NAEPAdmin_Pwd
$Secure_String_NAEPAdmin_Pwd