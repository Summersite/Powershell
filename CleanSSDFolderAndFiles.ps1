$dirs = gci F:\Deploy\Logs -exclude logs 
$dirs |% {remove-item $_ -recurse -force}
Remove-Item -recurse -Force F:\MDT_Logs\