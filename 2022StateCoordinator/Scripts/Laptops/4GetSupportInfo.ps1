Set-ExecutionPolicy Bypass -Scope Process -Force
clear-host
Write-host "Setting execution environment" -ForegroundColor Yellow
Set-ExecutionPolicy Bypass -Scope Process -Force

$LogPath = "C:\temp\logs"
$hostname = $env:COMPUTERNAME
$usbfolderPath = "D:\2023Statecoordinator\Logfiles"

if (Test-Path -Path $LogPath -PathType Container) {
    Write-Host "The Log folder exists." -ForegroundColor Green
} else {
    Write-Host "The Log folder does not exist. Creating Log folder" -ForegroundColor red
    # Create the folder if it doesn't exist
    New-Item -Path $LogPath -ItemType Directory | Out-Null
}


if (Test-Path -Path $usbfolderPath -PathType Container) {
    Write-Host "The Log folder D:\2023Statecoordinator\Logfiles exists." -ForegroundColor Green
} else {
    Write-Host "The Log folder D:\2023Statecoordinator\Logfiles does not exist. Creating Log folder" -ForegroundColor red
    # Create the folder if it doesn't exist
    New-Item -Path $usbfolderPath -ItemType Directory | Out-Null
}


$date = Get-Date
$dateString = $date.ToString("yyyyMMdd")
$logfile = "$dateString $hostname.log"
$logFilePath = Join-Path -Path $LogPath -ChildPath $logfile

Write-Host "Log file created: $logFilePath" -ForegroundColor Green

# Get operating system information
Write-Output "OS information:" >> $logFilePath
$operatingSystem = Get-WmiObject -Class win32_OperatingSystem

# Append operating system information to the log file
Write-host "Retrieving and Appending operating system information" -ForegroundColor Yellow
$operatingSystem | Out-File -FilePath $logFilePath -Append

Write-Output "Computer Details:" >> $logFilePath
$comp = Get-WmiObject -Class Win32_ComputerSystem 
"Manufacturer: {0}" -f $comp.Manufacturer >> $logFilePath
"Model:        {0}" -f $comp.Model >> $logFilePath
$computer2 = Get-WmiObject -Class Win32_ComputerSystemProduct 
"Service Tag:  {0}" -f $computer2.IdentifyingNumber >> $logFilePath
""
Write-host "Retrieving and Appending Computer Details" -ForegroundColor yellow

Write-host "Retrieving and Appending Hostname $hostname" -ForegroundColor yellow
Write-Output "Host Name:" >> $logFilePath
$hostname = $env:computername >> $logFilePath

Write-host "Retrieving and Appending ProcessorArchitecture" -ForegroundColor yellow
Write-Output "PROCESSOR ARCHITECTURE:" >> $logFilePath
$chip = $env:PROCESSOR_ARCHITECTURE >> $logFilePath

# List used disk space in GB for all drives, including network drives
Write-host "Retrieving and Appending Drive Iformation" -ForegroundColor yellow
Write-Output "Drive Iformation:" >> $logFilePath
Get-PSDrive | Where-Object { $_.Free -ne $null } | Select-Object Name, Used, Free, @{Name="UsedGB";Expression={"{0:N2}" -f ($_.Used / 1GB)}}, @{Name="FreeGB";Expression={"{0:N2}" -f ($_.Free / 1GB)}} >> $logFilePath

Write-host "Retrieving and Appending Firmware information" -ForegroundColor yellow
Write-Output "Firmware information:" >> $logFilePath
Get-WmiObject -Class win32_pnpsigneddriver | Where-Object {$_.deviceclass -eq "FIRMWARE"} | Select-Object devicename, driverversion | Format-Table >> $logFilePath

Write-host "Retrieving and Appending Microsoft Software information" -ForegroundColor yellow
Write-Output "Microsoft Software:" >> $logFilePath
Get-WmiObject -Class Win32_Product | Where-Object Vendor -eq 'Microsoft Corporation' | Select-Object Name, Version | Format-Table >> $logFilePath


# All other Software
Write-host "Retrieving and Appending Other Software information" -ForegroundColor yellow
Write-Output "Other Software:" >> $logFilePath
Get-ItemProperty -Path HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* |
    Select-Object DisplayName, DisplayVersion, Publisher, InstallDate |
    Format-Table –AutoSize >> $logFilePath

Write-host "Retrieving AD information if any" -ForegroundColor yellow
Write-Output "Is Computer AD connected" >> $logFilePath

function Test-DomainNetworkConnection {
    # Returns $true if the computer is attached to a network where it has a secure connection
    # to a domain controller
    #
    # Returns $false otherwise

    # Get operating system major and minor version
    $strOSVersion = (Get-WmiObject -Query "Select Version from Win32_OperatingSystem").Version
    $arrStrOSVersion = $strOSVersion.Split(".")
    $intOSMajorVersion = [UInt16]$arrStrOSVersion[0]
    if ($arrStrOSVersion.Length -ge 2) {
        $intOSMinorVersion = [UInt16]$arrStrOSVersion[1]
    } else {
        $intOSMinorVersion = [UInt16]0
    }

    # Determine if attached to domain network
    if (($intOSMajorVersion -gt 6) -or (($intOSMajorVersion -eq 6) -and ($intOSMinorVersion -gt 1))) {
        # Windows 8 / Windows Server 2012 or Newer
        # First, get all Network Connection Profiles, and filter it down to only those that are domain networks
        $domainNetworks = Get-NetConnectionProfile | Where-Object { $_.NetworkCategory -eq "Domain" }
    } else {
        # Windows Vista, Windows Server 2008, Windows 7, or Windows Server 2008 R2
        # (Untested on Windows XP / Windows Server 2003)
        # Get-NetConnectionProfile is not available; need to access the Network List Manager COM object
        # So, we use the Network List Manager COM object to get a list of all network connections
        # Then we get the category of each network connection
        # Categories: 0 = Public; 1 = Private; 2 = Domain; see: https://msdn.microsoft.com/en-us/library/windows/desktop/aa370800(v=vs.85).aspx

        $domainNetworks = ([Activator]::CreateInstance([Type]::GetTypeFromCLSID([Guid]"{DCB00C01-570F-4A9B-8D69-199FDBA5723B}"))).GetNetworkConnections() |
            ForEach-Object { $_.GetNetwork().GetCategory() } | Where-Object { $_ -eq 2 }
    }
    return ($domainNetworks -ne $null)
}

Write-output "Is this computer in AD" >> $logFilePath
Test-DomainNetworkConnection >> $logFilePath

Write-host "Retrieving and Appending Local User Account information" -ForegroundColor yellow
Write-output "Local User Accounts:" >> $logFilePath
$AllLocalAccounts = Get-WmiObject -Class Win32_UserAccount -Namespace "root\cimv2" -Filter "LocalAccount='$True'"
$AllLocalAccounts | ForEach-Object {
    $user = ([adsi]"WinNT://$computer/$($_.Name),user")
    
    $userObject = New-Object -TypeName PSObject -Property @{
        'Name'                 = $_.Name
        'Full Name'            = $_.FullName
        'Disabled'             = $_.Disabled
        'Status'               = $_.Status
        'Password Expires'     = $_.PasswordExpires
        'Account Type'         = $_.AccountType
        'Description'          = $_.Description
    }
    $userObject
} | Format-Table >> $logFilePath


# Display Wi-Fi information
Write-host "Retrieving and Appending WIFI Information" -ForegroundColor yellow
Write-output "WIFI Information:" >> $logFilePath
netsh wlan show interfaces >> $logFilePath

#*****************************************************************************
Write-host "Copy $logFile to $usbfolderPath" -ForegroundColor green
copy $LogPath\*.log $usbfolderPath
