#******* Delete files in folders - 15 days old *************

# $Currentuser = $(Get-WMIObject -class Win32_ComputerSystem | select username).username ***** for Domain user

$Currentuser = $env:username
$Now = Get-Date
$Days = "15"
$TargetFolder = "c:\windows\temp", "c:\temp", "c:\users\$currentuser\downloads"
$LastWrite = $Now.AddDays(-$days)
$Files = get-childitem $TargetFolder -include *.* -recurse 
    Where {$_.LastWriteTime -le "$LastWrite"} 
    foreach ($File in $Files)
{write-host "Deleting File $File" -foregroundcolor "Red"; `
    Remove-Item $File | out-null} -Force

#********** End Of Script **********************************