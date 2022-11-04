$scriptblock = {
Start-Transcript -Path "C:\Temp\SysTeamCopy-Transcript.txt" -Force -IncludeInvocationHeader
$MDTcred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList "enaepdev\mdtuser", (ConvertTo-SecureString -String "Deployment.1" -AsPlainText -Force)
$tsenv = New-Object -COMObject Microsoft.SMS.TSEnvironment
$ENAEPCode_PATH = $tsenv.Value("ENAEPCode_PATH")
Write-Output "ENAEPCode_PATH is $ENAEPCode_PATH"
$PSDrive = New-PSDrive -Name NAEP -PSProvider FileSystem -Root $ENAEPCode_PATH -Credential $MDTcred -Verbose
cp "naep:\SystemsTeam" -Destination "c:\" -Recurse -Force -Verbose
$PSDrive | Remove-PSDrive -Verbose
Stop-Transcript
}

[convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($scriptblock)) | clip 
