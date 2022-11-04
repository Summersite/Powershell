# Display Computer details 
cls
"Computer Details:" 
$comp = gwmi Win32_ComputerSystem 
"Manufacturer: {0}" -f $comp.Manufacturer 
"Model:        {0}" -f $comp.Model 
$computer2 = Get-WmiObject Win32_ComputerSystemProduct 
"Service Tag:  {0}" -f $computer2.IdentifyingNumber 
"" 

# Extract the driverversions and show device names as shown in the BIOS

get-wmiobject win32_pnpsigneddriver | where {$_.deviceclass -eq "FIRMWARE"} | select devicename,driverversion | ft
pause