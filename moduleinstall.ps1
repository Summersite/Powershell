Get-WmiObject win32_bios
$app = Get-WmiObject -Class Win32_Product | ? { $_.IdentifyingNumber -eq "{7E97C1B6-BC1C-4BBA-AA7E-CD1208CE1762}"}

install-Module -Name MSI
Get-MSIProperty -Property * -LiteralPath "INSERT PATH - SurfacePro4_Win10_16299_1803001_0.msi"

