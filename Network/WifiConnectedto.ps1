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

Clear


 $item = "Wi-Fi (Connected to Fulcrum Guest)"
  [string](netsh wlan show profiles name=([string](netsh wlan show interface | sls “\sSSID”) | sls “\:.+”| %{$_.Matches} | %{$ssid = $_.Value -replace “\:\s+”; $ssid}) key=clear | sls “Key Content”) | sls “\:.+”| %{$_.Matches} | %{$pass= $_.Value -replace “\:\s”};
  if ($ssid -eq "Fulcrum_Guest")
  {
    ItemPass -Title $item
  } else {
    ItemFail -Title $item
  }
