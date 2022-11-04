$Password = Read-Host -AsSecureString
$UserAccount = Get-LocalUser -Name "admin"
$UserAccount | Set-LocalUser -Password $Password
