# Determine if disk 0 is a USB attached unit

$VerbosePreference = "Continue"

$Boot = Get-Disk | ?{$_.BusType -eq "USB"} | Get-Partition | Get-Volume | ?{$_.FileSystemLabel -eq "BOOT"} | select -ExpandProperty DriveLetter
Write-Verbose "Boot drive is $Boot"
$Deploy = Get-Disk | ?{$_.BusType -eq "USB"} | Get-Partition | Get-Volume | ?{$_.FileSystemLabel -eq "Deploy"} | select -ExpandProperty DriveLetter
Write-Verbose "Deploy drive is $Deploy"

if ($Boot -and $Deploy) {
    $BCDPath = "$($Boot):\EFI\Microsoft\Boot\BCD"
    $BCDBak = "$($Deploy):\BCDBackup\BCD"

    Copy-Item -Path $BCDBak -Destination $BCDPath -Force
    Remove-Item -Path "$($Deploy):\SMSTSLog", "$($Deploy):\MININT", "$($Deploy):\_SMSTaskSequence" -Recurse -Force -ea SilentlyContinue
} 