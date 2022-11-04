# Create Hyper-V VM

$HyperVHost = "NAEP-VHOST6"
#$Build = "%BUILD_NUMBER%"
$Build = "Base-0.0.0.1"

# $SecureString = UnProtect-CmsMessage -To $Cert -Content $Password -IncludeContext | ConvertTo-SecureString  –asplaintext –force
# $UserName_PlainText = UnProtect-CmsMessage -To $Cert -Content $UserName -IncludeContext
# $cred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $UserName_PlainText,$SecureString

$VMParams = @{
    "Name" = $Build
    "MemoryStartupBytes" = 10000MB
    "Generation" = 2
    "SwitchName" = "External Virtual Switch (Exturnal Virtual Switch (192.168.1.x Network)) MDT"
    "NewVHDPath" = "e:\VM's\$Build\Virtual Hard Disks\$Build.vhdx"
    "NewVHDSizeBytes" = 127Gb
}

$CIMSession = Get-CimSession -Name Hyper-V
if (!($CIMSession)) {
    $CIMSession = New-CimSession -Authentication Negotiate -Credential $cred -ComputerName $HyperVHost -Name Hyper-V
}

$VM = New-VM @VMParams -CimSession $CIMSession
$VM | Set-VMNetworkAdapter -Name "Network Adapter" -StaticMacAddress "AA:BB:CC:DD:EE:FF"
$VM | Add-VMNetworkAdapter -SwitchName "External Virtual Switch (10.30.x.x Network)" -Name "Secondary MAC"
$VM | Set-VMMemory -Priority 100
$VM | Set-VMProcessor -Count 16

$vm|start-vm
<#
$disks = ($VM | Get-VMHardDiskDrive | Select -ExpandProperty Path) -replace '\\','\\' -replace "'", "\'"
Get-CimInstance -ClassName CIM_DataFile -Filter "Name='$($disks)'" -CimSession $CIMSession | Invoke-CimMethod -MethodName Delete | Out-Null
$VM | Remove-VMSnapshot –IncludeAllChildSnapshots
$VM | Remove-VM -Force -whatif
#> 
