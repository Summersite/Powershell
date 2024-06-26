#*******************************************************************************************************
Write-host "Setting executionpolicy"
Set-ExecutionPolicy Bypass -Scope Process -Force

# ******************************************************************************************************

$hostname= $env:computername
$chip= $env:PROCESSOR_ARCHITECTURE

#Setup Log for appending
$date = Get-Date
$date = $date.ToString("yyyyMMdd")
$createlogfiledir = md c:\temp\support
$createlogfiledir = $logfiledir
$logfile = "$createlogfiledir\Support $date $hostname.log" 

#**********************************************************************************************************************

# create folder on C:\
# md 'C:\temp\support'

#**********************************************************************************************************************

#OS version and Build number
Write-host "Retrieving OS Version"
Get-WmiObject win32_OperatingSystem >> $logfile

#**********************************************************************************************************************

# Display Computer details - Model and Service Tag +++ Working
#cls
Write-host "Retrieving Computer Details"
Write-Output "Computer Details:" >> $logfile
$comp = gwmi Win32_ComputerSystem 
"Manufacturer: {0}" -f $comp.Manufacturer >> $logfile
"Model:        {0}" -f $comp.Model >> C:\temp\support.txt
$computer2 = Get-WmiObject Win32_ComputerSystemProduct 
"Service Tag:  {0}" -f $computer2.IdentifyingNumber >> $logfile
""
$hostname= $env:computername >> $logfile
$chip= $env:PROCESSOR_ARCHITECTURE >> $logfile
 

# Extract the driverversions and show device names as shown in the BIOS

get-wmiobject win32_pnpsigneddriver | where {$_.deviceclass -eq "FIRMWARE"} | select devicename,driverversion | ft >> $logfile
# pause

#**********************************************************************************************************************

# Office version 
# https://www.codetwo.com/admins-blog/how-to-check-installed-software-version/
# get by vendor name
Write-host "Retrieving Current Microsoft Office Version"
Get-WmiObject -Class Win32_Product | where vendor -eq 'Microsoft Corporation' | select Name, Version >> $logfile

#All other Software
Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate | Format-Table –AutoSize >> $logfile

#************************************************************************************************************************

# AD or not

function Test-DomainNetworkConnection
{
    # Returns $true if the computer is attached to a network where it has a secure connection
    # to a domain controller
    # 
    # Returns $false otherwise

    # Get operating system  major and minor version
    $strOSVersion = (Get-WmiObject -Query "Select Version from Win32_OperatingSystem").Version
    $arrStrOSVersion = $strOSVersion.Split(".")
    $intOSMajorVersion = [UInt16]$arrStrOSVersion[0]
    if ($arrStrOSVersion.Length -ge 2)
    {
        $intOSMinorVersion = [UInt16]$arrStrOSVersion[1]
    } `
    else
    {
        $intOSMinorVersion = [UInt16]0
    }

    # Determine if attached to domain network
    if (($intOSMajorVersion -gt 6) -or (($intOSMajorVersion -eq 6) -and ($intOSMinorVersion -gt 1)))
    {
        # Windows 8 / Windows Server 2012 or Newer
        # First, get all Network Connection Profiles, and filter it down to only those that are domain networks
        $domainNetworks = Get-NetConnectionProfile | Where-Object {$_.NetworkCategory -eq "Domain"}
    } `
    else
    {
        # Windows Vista, Windows Server 2008, Windows 7, or Windows Server 2008 R2
        # (Untested on Windows XP / Windows Server 2003)
        # Get-NetConnectionProfile is not available; need to access the Network List Manager COM object
        # So, we use the Network List Manager COM object to get a list of all network connections
        # Then we get the category of each network connection
        # Categories: 0 = Public; 1 = Private; 2 = Domain; see: https://msdn.microsoft.com/en-us/library/windows/desktop/aa370800(v=vs.85).aspx

        $domainNetworks = ([Activator]::CreateInstance([Type]::GetTypeFromCLSID([Guid]"{DCB00C01-570F-4A9B-8D69-199FDBA5723B}"))).GetNetworkConnections() | `
            ForEach-Object {$_.GetNetwork().GetCategory()} | Where-Object {$_ -eq 2}
    }
    return ($domainNetworks -ne $null)
}
 

 Write-output "IS this computer in AD" >> $logfile
 Start-Sleep 15
 Test-DomainNetworkConnection >> $logfile

#***********************************************************************************************************************************************************

# For the below include group
$Obj = @()
$now = Get-Date
$AllLocalAccounts = Get-WmiObject -Class Win32_UserAccount -Namespace "root\cimv2" ` -Filter "LocalAccount='$True'" >> $logfile
$Obj = $AllLocalAccounts | ForEach-Object {
    $user = ([adsi]"WinNT://$computer/$($_.Name),user")
    
    New-Object -TypeName PSObject -Property @{
        'Name'                 = $_.Name
        'Full Name'            = $_.FullName
        'Disabled'             = $_.Disabled
        'Status'               = $_.Status
        'Password Expires'     = $_.PasswordExpires
        'Account Type'         = $_.AccountType
        'Description'          = $_.Description
          }
        }
$Obj

#************************************************************************************************************************************************************

 # = $result 
# Write-Output $result >> C:\temp\support.txt

#************************************************************************************************************************

#Create restore point
#Get-ExecutionPolicy
#Get-ExecutionPolicy -list
#Set-ExecutionPolicy remotesigned
Set-ExecutionPolicy Bypass -Scope Process -Force
Start-Service -DisplayName "Volume Shadow Copy"
Enable-ComputerRestore -Drive "C:\"  #enable system restore point (done via shadow copy)
Checkpoint-Computer -Description "Daily Restore Point - see date to the left" -RestorePointType "MODIFY_SETTINGS"
# Disable-ComputerRestore -Drive "C:\"
# Stop-Service -DisplayName "Volume Shadow Copy"

#************************************************************************************************************************



#**********************************************************************************************************************
