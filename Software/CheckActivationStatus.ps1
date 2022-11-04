Get-CimInstance -ClassName SoftwareLicensingProduct |
     where {$_.PartialProductKey} |
     select Description, LicenseStatus