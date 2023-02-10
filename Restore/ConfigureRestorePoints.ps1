Get-ExecutionPolicy
Get-ExecutionPolicy -list
Set-ExecutionPolicy remotesigned
Set-ExecutionPolicy Bypass -Scope Process -Force
Start-Service -DisplayName "Volume Shadow Copy"
Enable-ComputerRestore -Drive "C:\"  #enable system restore point (done via shadow copy)
Checkpoint-Computer -Description "Daily Restore Point - see date to the left" -RestorePointType "MODIFY_SETTINGS"
# Disable-ComputerRestore -Drive "C:\"
# Stop-Service -DisplayName "Volume Shadow Copy"