cls

# Internet connect manually
get-wmiobject win32_BIOS
get-wmiobject win32_BIOS >d:\B02015_BIOS_Before.txt 
(Get-Hotfix | sort installedon)[-1]
(Get-Hotfix | sort installedon)[-1] >d:\B02015_Before.txt
Start-Sleep 3
net stop eNAEP.WindowsUpdateMonitor #must be stopped
Start-Sleep 3
Set-Service -Name "wuauserv" -StartupType manual #must be started
net start wuauserv
Start-Sleep 3

# Below runs from fileexplorer
Invoke-Item (wusa update) (D:\SpectreMeltdown\Cumulative\windows10.0-kb4056891-x64_59726a743b65a221849572757d660f624ed6ca9e.msu)
Start-Sleep 10
(Get-Hotfix | sort installedon)[-1]
(Get-Hotfix | sort installedon)[-1] >d:\B02015_After.txt

#*******************************************************************************************************************************
# Internet connect manually 
net stop eNAEP.WindowsUpdateMonitor #must be stopped
Start-Sleep 3
Set-Service -Name "wuauserv" -StartupType manual #must be started
net start wuauserv

# next run Firmwareupdate
# run MSI 

# After restart
get-wmiobject win32_BIOS >d:\B02015_BIOS_After.txt


#******************************************************************************************************************************
cd\
d:
cd '.\SpectreMeltdown\SpeculationControl Module\SpeculationControl Module'

Start-Sleep 5
Save-Module -Name SpeculationControl  -Path C:\Temp # this part needs internet connectivity
Start-Sleep 5

Import-Module -Name c:\temp\SpeculationControl
Start-Sleep 5
# Check if script 1.0.3 SpeculationControl is loaded
get-module
Start-Sleep 5

Get-SpeculationControlSettings
Get-SpeculationControlSettings >d:\A67681_Check_after.txt

