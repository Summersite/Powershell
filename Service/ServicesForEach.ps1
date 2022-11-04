#Get-ScheduledTask
$allservices = Get-service 
$Service = (Get-service | Where {$_.Name -like 'xb*'})

Write-Host -ForegroundColor DarkYellow "Stopping XBOX related services"
foreach ($Service in $allservices){
    Stop-Service $Service
    Write-Host -text "$($Service.displayname) $($service.status)"
    }


Write-Host -ForegroundColor green -text "Starting XBOX related services"
foreach ($Services in $allservices){
    Start-Service $Services
    Write-Host -text "$($Services.displayname) $($services.status)"
    }




$wsus = get-service -name wuauserv
$wsus.Stop
$wsus.Start