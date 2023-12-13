get-psdrive | Where-Object {$_.free -gt 1} | Select-Object name, used, free
 

 get-psdrive | Where-Object {$_.free -gt 1} | Select-Object *
 get-psdrive | Where-Object {$_.free -gt 1} | ForEach-Object {'Zebra'}

 get-psdrive | Where-Object {$_.free -gt 1} | ForEach-Object {Write-Host "The space for" $_.root "is" ($_.free/1gb) -foregroundcolor green}

 get-psdrive | Where-Object {$_.free -gt 1} | ForEach-Object {Write-Host "The space for" $_.root "is" ($_.free/1gb) -foregroundcolor green}

 Get-PSDrive | ?{$_.Free -gt 1} | %{$Count = 0; Write-Host "";} { $_.Name + ": Used: " + "{0:N2}" -f ($_.Used/1gb) + " Free: " + "{0:N2}" -f ($_.free/1gb) + " Total: " + "{0:N2}" -f (($_.Used/1gb)+($_.Free/1gb)); $Count = $Count + $_.Free;}{Write-Host"";Write-Host "Total Free Space " ("{0:N2}" -f ($Count/1gb)) -backgroundcolor magenta}

 get-volume

# Set-ExecutionPolicy -ExecutionPolicy 