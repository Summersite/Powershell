# Install AWS Tools for Powershell
# Users who are running PowerShell 5.0 or newer can also install and update the Tools
# for Windows PowerShell from Microsoft's PowerShell Gallery website by running the following command. 
# https://www.powershellgallery.com/packages/AWSPowerShell/3.3.232.0

Save-Module -Name AWSPowerShell -Path D:\sourceInstall\Powershell\AWS
Install-Module -Name AWSPowerShell -force

# use group policy to set "Turn on Scriptexecution"

# This will install the module
install-packageprovider -name nuget -minimumversion 2.8.5.201 -force

# MSI Installer can be found here
# http://sdk-for-net.amazonwebservices.com/latest/AWSToolsAndSDKForNet.msi

# Verifying that script execution is enabled by running the Get-ExecutionPolicy cmdlet.
Get-ExecutionPolicy -List
Set-ExecutionPolicy undefined -Force
Set-ExecutionPolicy RemoteSigned -Force
Set-ExecutionPolicy undefined -Scope UserPolicy -Force
Set-ExecutionPolicy remotesigned -Scope UserPolicy -Force


#Wait until Key pressed
# Opens a new powershell instance
Start-Process PowerShell {[void][System.Console]::ReadKey($true)} -wait

# Wait for keypressed witin this powershell instance
[void](Read-Host 'Press Enter to continue…')

# Will wait for keypress (is not waiting for release of key)
# Please note that this solution will not work from within the PowerShell_ISE.exe environment. Microsoft did not implement there.
Write-Host "Press any key to continue ....."
$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

Install-Module -Name AWSPowerShell -

Get-ExecutionPolicy -List



# Get list of installed modules, which will show all loaded modules
# Result, see below
# Directory: C:\Program Files\AWS Tools\PowerShell
# ModuleType Version    Name                                ExportedCommands                                                                                                                    
# ---------- -------    ----                                ----------------                                                                                                                    
# Binary     3.3.234.0  AWSPowerShell                       {Add-AASScalableTarget, Add-ACMCertificateTag, Add-ADSConfigurationItemsToApplication, Add-AGResourceTag...}   
Get-Module -ListAvailable
