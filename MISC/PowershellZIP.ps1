Install-Module -Name 7Zip4PowerShell -Verbose
Get-Command -Module 7Zip4PowerShell
Compress-7Zip -Path C:\Temp -ArchiveFileName c:\Backup.zip -Format SevenZip -Password "SomeLONG&randuumP@ssf8zzaize" -EncryptFilenames
Expand-7Zip -ArchiveFileName c:\Backup.zip -Password "SomeLONG&randuumP@ssf8zzaize" -TargetPath C:\temp
Expand-7Zip -ArchiveFileName C:\Temp\OFFLineMedia.zip -TargetPath j:\
Get-7ZipInformation -ArchiveFileName C:\Temp\OFFLineMedia.zip