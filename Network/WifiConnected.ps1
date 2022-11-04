Function ItemPass ([String]$Title)
{
  $a = [string]::Format("`t  {0,-40}     ",$Title)
  write-host $a -nonewline; write-host -f Green "PASS"
}

Function ItemFail ([String]$Title)
{
  $a = [string]::Format("`t  {0,-40}     ",$Title)
  write-host $a -nonewline; write-host -f Red "FAIL"
}

Function ItemEval ([String]$Title, [String]$Value)
{
  $a = [string]::Format("`t  {0,-40}     ",$Title)
  write-host $a -nonewline; write-host -f Yellow $Value
}

Clear-Host
Write-Host
Write-Host
Write-Host  "`t===================================================================================="
Write-Host  "`t=                   eNAEP Laptop Quality Check Results                             ="
Write-Host  "`t===================================================================================="
Write-Host
Write-Host  "`t  ITEM                                         RESULT"
Write-Host  "`t  ========================================     ===================================="

#Get Screen Resolution
$item = "Screen Resolution (1366 x 768)"
$res = Get-WmiObject win32_videocontroller
if (($res.CurrentHorizontalResolution -ne 1366) -or ($res.CurrentVerticalResolution -ne 768)){
  ItemFail -Title $item
} else {
  ItemPass -Title $item
}

#Get TimeZone Name
$item = "Time Zone (Eastern Standard Time)"
$tz = [System.TimeZone]::CurrentTimeZone
if ($tz.StandardName -ne "Eastern Standard Time")
{  
  ItemFail -Title $item
} else {
  ItemPass -Title $item
}

$item = "Date and Time (Visual Inspection)"
$date = Get-Date -f F
ItemEval -Title $item -Value $date

$item = "Wi-Fi (On)"
$nic = Get-WmiObject -Class win32_networkadapter -Filter 'Name = "Intel(R) Centrino(R) Ultimate-N 6300 AGN"'
if ($nic.NetConnectionStatus -ne 2 ){ #http://blogs.technet.com/b/heyscriptingguy/archive/2014/01/15/using-powershell-to-find-connected-network-adapters.aspx for status ids
  ItemFail -Title $item
} else {
  ItemPass -Title $item
}

Write-Host
Write-Host  "`t===================================================================================="
Write-Host
Write-Host
#Write-Host  "`t Press any key to close..."
#$host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")