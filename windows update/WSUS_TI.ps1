 
# Script: ti_wsus.ps1
# Note: The script will perform the following:
# 	-import all ti related settings
#	-set the wsus to manual
#	-start the wsus service
#	-check for all updates
#	-download all updates
#	-apply all updates * holding back reboot
#	-prompt the user to reboot when all updates are applied.
#
# Depending on how far back the updates are this may need to be
# run several times. Please rerun after reboot to check for 
# additional updates.
# 
# The script needs be run with the admin token (right click "run as admin") 
# and with execution policy enabled in PowerShell
#
# To temporarily enable execution policy run the script with 
# 	"powershell –ExecutionPolicy Bypass"
#
# RAP 08.12.18 version 1.4
#


if(! ( Test-Path "HKLM:Software\Policies\Microsoft\Windows\WindowsUpdate" ) ) {
  New-Item -Path "HKLM:Software\Policies\Microsoft\Windows\WindowsUpdate" | Out-Null
}

if(! ( Test-Path "HKLM:Software\Policies\Microsoft\Windows\WindowsUpdate\AU" ) ) {
  New-Item -Path "HKLM:Software\Policies\Microsoft\Windows\WindowsUpdate\AU" | Out-Null
}

Set-ItemProperty -Path "HKLM:\software\policies\Microsoft\Windows\WindowsUpdate" -Name WUServer -Value "http://wsus.ti.mil:8530" -Type String -force | Out-Null
Set-ItemProperty -Path "HKLM:\software\policies\Microsoft\Windows\WindowsUpdate" -Name WUStatusServer -Value "http://wsus.ti.mil:8530" -Type String -force | Out-Null
Set-ItemProperty -Path "HKLM:\software\policies\Microsoft\Windows\WindowsUpdate\AU" -Name UseWUServer -Value "1" -Type DWORD -force | Out-Null
Set-ItemProperty -Path "HKLM:\software\policies\Microsoft\Windows\WindowsUpdate\AU" -Name NoAUShutdownOption -Value "1" -Type DWORD -force | Out-Null
Set-ItemProperty -Path "HKLM:\software\policies\Microsoft\Windows\WindowsUpdate\AU" -Name AUOptions -Value "3" -Type DWORD -force | Out-Null
Set-ItemProperty -Path "HKLM:\software\policies\Microsoft\Windows\WindowsUpdate\AU" -Name NoAutoUpdate -Value "0" -Type DWORD -force | Out-Null
Set-ItemProperty -Path "HKLM:\software\policies\Microsoft\Windows\WindowsUpdate\AU" -Name DetectionFrequency -Value "22" -Type DWORD -force | Out-Null
Set-ItemProperty -Path "HKLM:\software\policies\Microsoft\Windows\WindowsUpdate\AU" -Name DetectionFrequencyEnabled -Value "1" -Type DWORD -force | Out-Null
Set-ItemProperty -Path "HKLM:\software\policies\Microsoft\Windows\WindowsUpdate\AU" -Name AutoInstallMinorUpdates -Value "0" -Type DWORD -force | Out-Null

Set-Service  wuauserv -StartupType Automatic
Start-Service  wuauserv -Force | Out-Null

$OSVersion = Get-WmiObject -Class Win32_OperatingSystem|Select-Object Version
if ($OSVersion -Match "6.3"){
    wuauclt /detectnow /resetAuthorizations
}
 else {
       $AutoUpdates = New-Object -ComObject "Microsoft.Update.AutoUpdate"
       $AutoUpdates.DetectNow()
    }

$UpdateSession = New-Object -Com Microsoft.Update.Session
$UpdateSearcher = $UpdateSession.CreateUpdateSearcher()
 
Write-Host("Searching for applicable updates...") -Fore Green
 
$SearchResult = $UpdateSearcher.Search("IsInstalled=0 and Type='Software'")
 
Write-Host("")
Write-Host("List of applicable items on the machine:") -Fore Green
For ($X = 0; $X -lt $SearchResult.Updates.Count; $X++){
    $Update = $SearchResult.Updates.Item($X)
    Write-Host( ($X + 1).ToString() + ": " + $Update.Title)
}
 
If ($SearchResult.Updates.Count -eq 0) {
    Write-Host("There are no applicable updates.")
    Exit
}
 
$UpdatesToDownload = New-Object -Com Microsoft.Update.UpdateColl
 
For ($X = 0; $X -lt $SearchResult.Updates.Count; $X++){
    $Update = $SearchResult.Updates.Item($X)
    $Null = $UpdatesToDownload.Add($Update)
}
 
Write-Host("")
Write-Host("Downloading Updates...")  -Fore Green

$Downloader = $UpdateSession.CreateUpdateDownloader()
$Downloader.Updates = $UpdatesToDownload
$Null = $Downloader.Download()
 
$UpdatesToInstall = New-Object -Com Microsoft.Update.UpdateColl
 
For ($X = 0; $X -lt $SearchResult.Updates.Count; $X++){
    $Update = $SearchResult.Updates.Item($X)
    If ($Update.IsDownloaded) {
        $Null = $UpdatesToInstall.Add($Update)        
    }
}
 
$Install = "Y"
$Reboot  = $Install
 
If ($Install.ToUpper() -eq "Y"){
    Write-Host("")
    Write-Host("Installing Updates...") -Fore Green
 
    $Installer = $UpdateSession.CreateUpdateInstaller()
    $Installer.Updates = $UpdatesToInstall
 
    $InstallationResult = $Installer.Install()
 
    Write-Host("")
    Write-Host("List of Updates Installed with Results:") -Fore Green
 
    For ($X = 0; $X -lt $UpdatesToInstall.Count; $X++){
        Write-Host($UpdatesToInstall.Item($X).Title + ": " + $InstallationResult.GetUpdateResult($X).ResultCode)
    }
 
    Write-Host("")
    Write-Host("Installation Result: " + $InstallationResult.ResultCode)
    Write-Host("    Reboot Required: " + $InstallationResult.RebootRequired)

    If ($InstallationResult.RebootRequire -eq $True){
        If (!$Reboot){
            $Reboot = Read-Host("Would you like to install these updates now? (Y/N)")
        }
 
        If ($Reboot.ToUpper() -eq "Y" -or $Reboot.ToUpper() -eq "YES"){
            Write-Host("")
            Write-Host("Rebooting...") -Fore Green
            (Get-WMIObject -Class Win32_OperatingSystem).Reboot()
        }
    }
}
