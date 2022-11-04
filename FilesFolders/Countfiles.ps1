$hostname=hostname
$directory = "C:\DATA"
$dteCurrentDate = Get-Date –f "yyyy/MM/dd"

$FolderItems = Get-ChildItem $directory -recurse
$Measurement = $FolderItems | Measure-Object -property length -sum
$colitems = $FolderItems | measure-Object -property length -sum
"$hostname;{0:N2}" -f ($colitems.sum / 1MB) + "MB;" + $Measurement.count + " files;" + "$dteCurrentDate"