$MicrosoftUpdateSession = New-Object -ComObject Microsoft.Update.Session
$SearchResult = $null
$UpdateSearcher = $MicrosoftUpdateSession.CreateUpdateSearcher()
$UpdateSearcher.Online = $true
$SearchResult = $UpdateSearcher.Search("IsInstalled=1 and Type='Software'")
$x = 1
foreach($Update in $SearchResult.Updates | Sort-Object {$_.Title})
{
Write-Host "$x : $($Update.Title + " - " + $Update.SecurityBulletinIDs)"
$x += 1
}