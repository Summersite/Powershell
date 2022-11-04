cls

Get-ChildItem -Path F:\Deploy\Logs -Recurse -Force
Get-ChildItem -Path F:\MDT_Logs -Recurse -Force

Start-Sleep 2

$dirs = gci f:\MDT_Logs -exclude dummy
$dirs |% {remove-item $_ -recurse -force}
Start-Sleep 2

$dirs1 = gci F:\Deploy\Logs -exclude default
$dirs1 |% {remove-item $_ -recurse -force}
Start-Sleep 2

$dirs2 = gci F:\Deploy\Logs\default -exclude dummy
$dirs2 |% {remove-item $_ -recurse -force}
Start-Sleep 2

Get-ChildItem -Path F:\Deploy\Logs -Recurse -Force
Get-ChildItem -Path F:\MDT_Logs -Recurse -Force



