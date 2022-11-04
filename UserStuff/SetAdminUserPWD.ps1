$password = read-host -assecurestring
$useraccount = get-localuser -Name "admin"
$useraccount | Set-LocalUser -passwordneverexpires $true -Password $password  