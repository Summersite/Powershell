$AllowedHosts = "NAEP21DEV1IPMS"
$AllowedHostsFQDN = "NAEP21DEV1IPMS.naepims.org"
$ADServer = 'NAEP20PRD1DCT02.naepims.org'
$Description = "Execute IPMS Inventory scripts"
$sgParams = @{
    Description = $Description
    DisplayName = $Description
    GroupCategory = [Microsoft.ActiveDirectory.Management.ADGroupCategory]::Security
    GroupScope = [Microsoft.ActiveDirectory.Management.ADGroupScope]::Global
    Name = "sgIPMSInv"
    Path = "OU=DevOps,OU=_Security Groups,OU=HII,DC=naepims,DC=org"
}
$sg = New-ADGroup @sgParams -Verbose -PassThru
$sg | Add-ADGroupMember -Members (Get-ADComputer -Identity $AllowedHosts) -Verbose
$gmsaParams = @{
    Description = $Description
    DNSHostName = $ADServer
    Name = "gmsaIPMSInv"
    PrincipalsAllowedToRetrieveManagedPassword = $sg.DistinguishedName
    Enabled = $true
    ServicePrincipalNames = "schedule/$AllowedHostsFQDN"
}
$gmsa = New-ADServiceAccount @gmsaParams -Verbose -PassThru
$gmsa.DistinguishedName