#To find certificates that will expire in the next 30 days on all domain servers, use this PowerShell script:

$servers= (Get-ADComputer -LDAPFilter "(&(objectCategory=computer)(operatingSystem=Windows Server*) (!serviceprincipalname=MSClusterVirtualServer) (!(userAccountControl:1.2.840.113556.1.4.803:=2)))").Name
$result=@()
foreach ($server in $servers)
{
$ErrorActionPreference="SilentlyContinue"
$getcert=Invoke-Command -ComputerName $server { Get-ChildItem -Path Cert:\LocalMachine\My -Recurse -ExpiringInDays 30}
foreach ($cert in $getcert) {
$result+=New-Object -TypeName PSObject -Property ([ordered]@{
'Server'=$server;
'Certificate'=$cert.Issuer;
'Expires'=$cert.NotAfter
})
}
}
Write-Output $result