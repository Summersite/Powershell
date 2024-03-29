Start-Transcript -Path "D:\SystemsTeamFolder\S3LogMigration.txt" -Append -Force
$7zipPath = "$env:ProgramFiles\7-Zip\7z.exe"

if (-not (Test-Path -Path $7zipPath -PathType Leaf)) {
    throw "7 zip file '$7zipPath' not found"
}

Set-Alias 7zip $7zipPath

import-module AWSPowerShell
Initialize-AWSDefaults -Region us-east-1 -AccessKey "AKIAVKJKWOUTA5WGNAMG" -SecretKey "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"

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
[System.Net.ServicePointManager]::CheckCertificateRevocationList = $false;
[System.Net.ServicePointManager]::ServerCertificateValidationCallback = $null

gci D:\ArchiveSystemlogs\Security\Archive-*.evtx, C:\Windows\System32\winevt\Logs\Archive-*.evtx | %{
    #Compress-Archive -Path $_.FullName -DestinationPath "D:\Log Files\$($_.BaseName)"
    7zip  a -bd "D:\Log Files\$($_.BaseName).7z" "$($_.FullName)"
    Write-S3Object -BucketName fulcrum-logs -File "D:\Log Files\$($_.BaseName).7z" -Key "$($env:COMPUTERNAME)\$($_.BaseName).7z" -Verbose
    if ($?) {Remove-Item $_ -Verbose}
    Remove-Item "D:\Log Files\$($_.BaseName).7z" -Verbose
}

Stop-Transcript