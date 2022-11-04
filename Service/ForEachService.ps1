#$allservices = Get-service  #Not needed as the below command will get all services, then filter it to just the xbox services in one command
$xboxServices = (Get-Service | Where {$_.Name -like 'xb*'}) #Renamed $Service to $xboxServices to be more descriptive and since it holds multiple values (every xbox service)

Write-Host -ForegroundColor DarkYellow "Stopping XBOX related services"
foreach ($Service in $xboxServices){ #Updated to run against the $xboxServices array
    Stop-Service -Force $Service #Removed quotes, as this command takes the data directly from the object not a string like the below Write-Host
    Write-Host "$($Service.displayname) $($service.status)"
}

Write-Host -ForegroundColor green "Starting XBOX related services"
foreach ($Service in $xboxServices){ #Updated to run against the $xboxServices array
    Start-Service $Service #Removed quotes, as this command takes the data directly from the object not a string like the below Write-Host
    Write-Host "$($Service.displayname) $($service.status)" #Removed -text, thats a parameter from my Write-ScreenLog function, you can submit text to Write-Host directly
}

 stop-Service -Force XblAuthManager