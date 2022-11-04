$cred = Get-Credential -UserName jjohannsenda@naepims.org -Message "NAEPIMS credentials"
Get-ADComputer -Server NAEP15PRD1DCT01.naepims.org -Filter * -Credential $cred -SearchBase "OU=Servers, DC=naepims, DC=org" | ConvertTo-Csv | clip 
help ADComputer
$cred = Get-Credential -UserName jjohannsenda@naepims.org -Message "NAEPIMS credentials"
Get-ADComputer -Server NAEP-DS2.naepims.org -Filter * -Credential $cred -SearchBase "OU=Servers, DC=naepims, DC=org" | ConvertTo-Csv | clip 