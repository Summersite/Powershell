# https://support.microsoft.com/en-us/help/4074629/understanding-the-output-of-get-speculationcontrolsettings-powershell
#***********************************************************************************************************************
#******************Understanding Get-SpeculationControlSettings PowerShell script output********************************
#***********************************************************************************************************************

Install-Module SpeculationControl
Get-InstalledModule
$SaveExecutionPolicy = Get-ExecutionPolicy

Set-ExecutionPolicy RemoteSigned -Scope Currentuser
Import-Module SpeculationControl
Get-SpeculationControlSettings >c:\temp\SPECULATION.txt

# Reset the execution policy to the original state
Set-ExecutionPolicy $SaveExecutionPolicy -Scope Currentuser