Add-WindowsFeature RSAT-AD-PowerShell
Install-ADServiceAccount -Identity gmsaLogsMakid #
Test-ADServiceAccount -Identity gmsaLogsMakid
