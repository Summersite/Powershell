$dirs = gci c:\windows\temp -exclude deploymentlogs 
$dirs |% {remove-item $_ -recurse -force}