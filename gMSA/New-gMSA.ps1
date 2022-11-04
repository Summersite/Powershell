$AllowedHosts = "NAEP21PRD1NAA01", "NAEP22DEV1SHP01", "NAEP18PRD1SPW01", "NAEP17PRD1TFS01" # servers that are  included in the security group sgLogMove  
$AllowedHostsFQDN = "NAEP21DEV1IPMS.naepims.org" # It is used only in SPN. Which we don’t use for our task
$ADServer = 'NAEP20PRD1DCT02.naepims.org'
$Description = "Execute IPMS Inventory scripts"
$sgParams = @{
    Description = $Description
    DisplayName = $Description
    GroupCategory = "Security"
    GroupScope = "Global"
    Name = "sgLogMove"
    Path = "OU=DevOps,OU=_Security Groups,OU=HII,DC=naepims,DC=org"
}
$sg = Get-ADGroup -Identity $sgParams.Name
if (!$sg) {$sg = New-ADGroup @sgParams -Verbose -PassThru}
$Computers = $AllowedHosts | %{Get-ADComputer -Identity $_}
$sg | Add-ADGroupMember -Members $Computers -Verbose
$gmsaParams = @{
    Description = $Description
    DNSHostName = $ADServer
    Name = "gmsaLogMover"
    PrincipalsAllowedToRetrieveManagedPassword = $sg.DistinguishedName
    Enabled = $true
    ServicePrincipalNames = "schedule/$AllowedHostsFQDN" # It is used only in SPN. Which we don’t use for our task
}
$gmsa = Get-ADServiceAccount -Identity $gmsaParams.Name -Verbose
if (!$gmsa) {$gmsa = New-ADServiceAccount @gmsaParams -Verbose -PassThru}
$gmsa | Set-ADServiceAccount -PrincipalsAllowedToRetrieveManagedPassword $sg