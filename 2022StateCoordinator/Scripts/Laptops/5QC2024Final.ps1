#***************************************************************************
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Bypass -Force

# ****************************************************************************************
$LogPath = "C:\temp\logs"
$date = Get-Date
$date = $date.ToString("yyyyMMdd")
$hostname= $env:computername
#$logfile = "$logPath\$($hostname)-$date-QC.log" #that $($variableName) format is a special way of specifying the variable within a string so that it knows it is its own variable
#$env:computername > $logfile
$usbfolderPath = "D:\2023Statecoordinator\Logfiles"
#*****************************************************************************************
if (Test-Path -Path $LogPath -PathType Container) {
    Write-Host "The Log folder C:\temp\logs exists." -ForegroundColor Green
} else {
    Write-Host "The Log folder C:\temp\logs does not exist. Creating Log folder" -ForegroundColor red
    # Create the folder if it doesn't exist
    New-Item -Path $LogPath -ItemType Directory | Out-Null
}

$logfile = "$logPath\$($hostname)-$date-QC.log"
$env:computername > $logfile

if (Test-Path -Path $usbfolderPath -PathType Container) {
    Write-Host "The Log folder D:\2023Statecoordinator\Logfiles exists." -ForegroundColor Green
} else {
    Write-Host "The Log folder D:\2023Statecoordinator\Logfiles does not exist. Creating Log folder" -ForegroundColor red
    # Create the folder if it doesn't exist
    New-Item -Path $usbfolderPath -ItemType Directory | Out-Null
}
#*****************************************************************************************

Get-WmiObject win32_SystemEnclosure | select serialnumber >> $logfile
Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate | Format-Table –AutoSize >> $logfile
# Get-WMIObject -Query "SELECT * FROM Win32_Product Where Name Like '%Office 16%'" | Format-Table –AutoSize >> $logfile
Get-CimInstance -Class Win32_Product | Format-Table –AutoSize >> $logfile
#******************************************************************************
Start-Sleep -Seconds 5

# For the below include group
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
} | Format-Table >> $logfile

# Start-Sleep -Seconds 5

# remove-LocalUser -name "jimmy"

Start-Sleep -Seconds 5

# Local User

# Get-LocalUser | Where-Object -Property Enabled -eq True >> $logfile

Start-Sleep -Seconds 5

netsh wlan show profiles >> $logfiles

Start-Sleep -Seconds 5

# netsh wlan delete profile name="*" >> $logfiles

Start-Sleep -Seconds 5

copy $LogPath\*.log $usbfolderPath

Start-Sleep -Seconds 10

rm $LogPath -r -force 

Start-Sleep -Seconds 5

rm c:\sc2022 -r -force

Start-Sleep -Seconds 5

Clear-RecycleBin -Force

dir c:\ 

