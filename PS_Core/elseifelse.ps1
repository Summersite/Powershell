# https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_if?view=powershell-5.1
# https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_comparison_operators?view=powershell-5.1

# If else
if ($a -gt 2) {
    Write-Host "The value $a is greater than 2."
}
else {
    Write-Host ("The value $a is less than or equal to 2," +
        " is not created or is not initialized.")
}



# If elseif else

$a=10

if ($a -gt 2) {
    Write-Host "The value $a is greater than 2."
}
elseif ($a -eq 2) {
    Write-Host "The value $a is equal to 2."
}
else {
    Write-Host ("The value $a is less than 2 or" +
        " was not created or initialized.")
}


#Using the ternary operator syntax
#PowerShell 7.0 introduced a new syntax using the ternary operator. It follows the C# ternary operator syntax:

$path= W:\Badges
$message = (Test-Path $path) ? "Path exists" : "Path not found"

$service = Get-Service BITS
$service.Status -eq 'Running' ? (Stop-Service $service) : (Start-Service $service)

$PSVersionTable
$PSVersionTable.PSVersion
$PSVersionTable.PSVersion.Major
powershell -command "(Get-Variable PSVersionTable -ValueOnly).PSVersion"
Get-Host