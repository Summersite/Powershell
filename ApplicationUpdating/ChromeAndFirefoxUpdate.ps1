<# Script for updating Chrome and FireFox. Also added functions to test the browser and close with new version checked at end and clean up of files and directory#>
# Variables:
$ChromeExe = "$Env:ProgramFiles\\Google\\Chrome\\Application\\Chrome.exe"
$FireFoxExe = "$Env:ProgramFiles\\Mozilla Firefox\\firefox.exe"
$ChromeDLuri = "https://dl.google.com/tag/s/appguid%3D%7B8A69D345-D564-463C-AFF1-A69D9E530F96%7D%26iid%3D%7B80992A06-67F6-6E9F-99DA-7F46003CB74F%7D%26lang%3Den%26browser%3D4%26usagestats%3D1%26appname%3DGoogle%2520Chrome%26needsadmin%3Dprefers%26ap%3Dx64-stable-statsdef_1%26brand%3DCHBD%26installdataindex%3Dempty/update2/installers/ChromeSetup.exe"
$FireFoxDLuri = "https://download.mozilla.org/?product=firefox-stub&os=win&lang=en-US"
$TempDLdir = "C:\\TempDLdir"

# Check for the directory for the installers and create if does not exist, if exists, delete and recreate.
if ((Test-Path -Path $TempDLdir) -eq $true) {
    Remove-Item $TempDLdir -Recurse -Force
    Start-Sleep 10
    New-Item $TempDLdir -Type Directory
}
else {
    New-Item $TempDLdir -Type Directory
}

# Check to see if the broswers are installed and return the currently installed Version (FireFox and Chrome only)
Write-Host "Checking to see if Chrome and Firefox are installed and return the currently installed version"
#Chrome Check#
$ChromeVersion = (Get-Item (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\chrome.exe').'(Default)').VersionInfo
Write-Host "$ChromeVersion"
#FireFox Check#
$FireFoxVersion = (Get-Item (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\firefox.exe').'(Default)').VersionInfo
Write-Host "$FireFoxVersion"

# Download the installer for Chrome or FireFox (or both), alerts if either is not installed, Tests the browser after installation.
if ($ChromeVersion = $null) {
    Write-Host "Chrome does not seem to be installed, please check the system to verify."
}
else {
    Invoke-WebRequest -Uri "$ChromeDLuri" -OutFile "$TempDLdir\\ChromeInstaller.exe"
    Set-Location -Path "$TempDLdir"
    ./ChromeInstaller.exe /Silent /Install

    Start-Sleep 180
    
    Start-Process -FilePath $ChromeExe -PassThru "https://www.google.com"

    Start-Sleep 30

    $Chrome = Get-Process -Name Chrome -ErrorAction SilentlyContinue

    if ($Chrome) {
        $Chrome.CloseMainWindow()
        if ($Chrome.HasExited) {
            Write-Host "Chrome has been updated and successfully opened and closed gracefully, the new version is listed below."
        }
        else {
            Stop-Process $Chrome -Force
            Write-Host "Chrome seems to have installed, but did not close gracefully and needed to be forced. Please check the system to see if there are any issues."
        }
    }
}

if ($FireFoxVersion = $null) {
    Write-Host "FireFox does not seem to be installed, please check the system to verify."
}
else {
    Invoke-WebRequest -Uri "$FireFoxDLuri" -OutFile "$TempDLdir\\FireFoxInstaller.exe"
    Set-Location -Path "$TempDLdir"
    ./FireFoxInstaller.exe /Silent /Install

    Start-Sleep 180
    
    Start-Process -FilePath $FireFoxExe -PassThru "https://www.google.com"

    Start-Sleep 30

    $FireFox = Get-Process -Name FireFox -ErrorAction SilentlyContinue

    if ($FireFox) {
        $FireFox.CloseMainWindow()
        if ($FireFox.HasExited) {
            Write-Host "FireFox has been updated and successfully opened and closed gracefully, the new version is listed below."           
        }
        else {
            Stop-Process $FireFox -Force
            Write-Host "FireFox seems to have installed, but did not close gracefully and needed to be forced. Please check the system to see if there are any issues."
        }
    }
}

# Find and stop any processes using the temp folder, Cleanup files, pull newly installed versions, and exit
    (Get-Item (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\chrome.exe').'(Default)').VersionInfo
    (Get-Item (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\firefox.exe').'(Default)').VersionInfo
    Start-Sleep 30
    Set-Location -Path "$env:SYSTEMROOT"
    Remove-Item -Path "$TempDLdir" -Recurse -Force
    
Exit