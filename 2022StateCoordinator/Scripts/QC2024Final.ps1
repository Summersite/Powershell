Set-ExecutionPolicy -ExecutionPolicy unrestricted -Scope CurrentUser -Force
#***************************************************************************
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Bypass -Force

Function Pause ($Message = "Press any key to continue...") {
   # Check if running in PowerShell ISE
   If ($psISE) {
      # "ReadKey" not supported in PowerShell ISE.
      # Show MessageBox UI
      $Shell = New-Object -ComObject "WScript.Shell"
      $Button = $Shell.Popup("Click OK to continue.", 0, "Hello", 0)
      Return
   }
 
   $Ignore =
      16,  # Shift (left or right)
      17,  # Ctrl (left or right)
      18,  # Alt (left or right)
      20,  # Caps lock
      91,  # Windows key (left)
      92,  # Windows key (right)
      93,  # Menu key
      144, # Num lock
      145, # Scroll lock
      166, # Back
      167, # Forward
      168, # Refresh
      169, # Stop
      170, # Search
      171, # Favorites
      172, # Start/Home
      173, # Mute
      174, # Volume Down
      175, # Volume Up
      176, # Next Track
      177, # Previous Track
      178, # Stop Media
      179, # Play
      180, # Mail
      181, # Select Media
      182, # Application 1
      183  # Application 2
 
   Write-Host -NoNewline $Message
   While ($KeyInfo.VirtualKeyCode -Eq $Null -Or $Ignore -Contains $KeyInfo.VirtualKeyCode) {
      $KeyInfo = $Host.UI.RawUI.ReadKey("NoEcho, IncludeKeyDown")
   }
}

# ****************************************************************************************
$LogPath = "C:\temp\logs"
$date = Get-Date
$date = $date.ToString("yyyyMMdd")
$hostname= $env:computername
$logfile = "$logPath\$($hostname)_$date-QC.log" #that $($variableName) format is a special way of specifying the variable within a string so that it knows it is its own variable
$env:computername > $logfile
$usbfolderPath = "D:\2023Statecoordinator\Logfiles"
#*****************************************************************************************
if (Test-Path -Path $folderPath -PathType Container) {
    Write-Host "The Log folder C:\temp\logs exists." -ForegroundColor Green
} else {
    Write-Host "The Log folder C:\temp\logs does not exist. Creating Log folder" -ForegroundColor red
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

Get-LocalUser | Where-Object -Property Enabled -eq True >> $logfile

Start-Sleep -Seconds 5

netsh wlan show profiles >> $logfiles

Start-Sleep -Seconds 5

netsh wlan delete profile name="*" >> $logfiles

Start-Sleep -Seconds 5

copy $LogPath\*.log $usbfolderPath

Start-Sleep -Seconds 5

rm $LogPath -r -force 

Start-Sleep -Seconds 5

rm c:\sc2022 -r -force

Start-Sleep -Seconds 5

Clear-RecycleBin -Force

dir c:\ 

