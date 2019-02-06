$scriptblock = {
Start-Transcript -Path "C:\windows\Temp\eNAEPCodeCopy-Transcript.txt" -Force -IncludeInvocationHeader
$MDTcred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList "enaepdev\mdtuser", (ConvertTo-SecureString -String "Deployment.1" -AsPlainText -Force)
try {
    $tsenv = New-Object -COMObject Microsoft.SMS.TSEnvironment -ea 4
    $ENAEPCode_PATH = $tsenv.Value("ENAEPCode_PATH")
} catch {
    $ENAEPCode_PATH = $env:ENAEPCode_PATH
}

Write-Output "ENAEPCode_PATH is $ENAEPCode_PATH"
$PSDrive = New-PSDrive -Name NAEP -PSProvider FileSystem -Root $ENAEPCode_PATH -Credential $MDTcred -Verbose
cp "naep:\eNAEPApplication" -Destination "C:\eNAEPApplication" -Recurse -Force -Verbose
$PSDrive | Remove-PSDrive -Verbose
Stop-Transcript
}

[convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($scriptblock)) | clip 
