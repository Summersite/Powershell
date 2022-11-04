# this script is used to setup Powershell with module to get other modules from WWW>Powershellgallery.com

Install-PackageProvider Nuget –Force

Install-Module –Name PowerShellGet –Force

Update-Module -Name PowerShellGet
