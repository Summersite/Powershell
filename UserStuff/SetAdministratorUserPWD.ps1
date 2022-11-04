$password = read-host -assecurestring
$useraccount = get-localuser -Name "administrator"
$useraccount | Set-LocalUser -passwordneverexpires $true -Password $password  