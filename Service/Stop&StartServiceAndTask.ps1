#* stop and start Task and service
Write-host Stopping task enaep.systems.updateplatform.service.client.exe
cmd /c taskkill /IM enaep.systems.updateplatform.service.client.exe /F
Start-sleep 3
Write-host Stopping Service ENAEPUpdater
Stop-Service 'ENAEPUpdater'
start-sleep 10
Write-host Starting task enaep.systems.updateplatform.service.client
start 'C:\Program Files\NAEP\eNAEP Updater Client\eNAEP.Systems.UpdatePlatform.Service.Client.exe'
start-sleep 10
Write-host Starting Service 'ENAEPUpdater'
start-service 'eNAEPUpdater'