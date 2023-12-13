# Below one is working 
$remoteFilePath = '\\192.168.2.104\pictures'
$localpath = 'g:\pictures\'
Copy-Item  -PassThru $remoteFilePath $localpath  -Force -Recurse