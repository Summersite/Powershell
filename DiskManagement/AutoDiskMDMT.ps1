# List all disks
Get-Disk

# List disks that are not system disks
# to avoid accidently formatting your system drive
Get-Disk | Where-Object IsSystem -eq $False
# Clear a disk regardless of whether it contains data or OEM partitions
Clear-Disk -Number 2 -RemoveData –RemoveOEM
Initialize-Disk -Number 2
New-Partition –DiskNumber 2 -AssignDriveLetter –UseMaximumSize
Set-Partition –DriveLetter E -NewDriveLetter T
Format-Volume -DriveLetter T -FileSystem NTFS -NewFileSystemLabel BupData -Confirm:$false
get-volume