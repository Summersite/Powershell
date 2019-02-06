dir C:\test* | foreach { [io.directory]::delete($_.fullname) }
remove-item -Recurse -Force c:\test
Remove-Item -recurse c:\test\* -exclude UpdatePackage

Get-ChildItem "C:\test" -Exclude "updatepackage" | ? { $_.PSIsContainer } |
  Remove-Item -Recurse -Force

$dirs = gci c:\test -directory -exclude updatepackage 
$dirs |% {remove-item $_ -recurse -force}

