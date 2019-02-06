[CmdletBinding()]  
Param(  
    [string]$Source,
    [string]$Destination,
    [string]$Include,
    [string]$Exclude,
    [string]$LogFileName,
    [switch]$Force = $True

)  

$VerbosePreference = "Continue"

Write-Verbose "Copy from [$Source] to [$Destination]"

$SourceEnumParameters = @{
    Recurse = $True
    Path = $Source
    Destination = $Destination
    Force = $Force
}

$CopyParameters = @{
    Destination = $Destination
    Force = $Force
}

if (![String]::IsNullOrEmpty($Include)) {$SourceEnumParameters += @{Include = $Include}}
if (![String]::IsNullOrEmpty($Exclude)) {$SourceEnumParameters += @{Exclude = $Exclude}}

$error.clear()
$Output = Copy-Item @SourceEnumParameters -PassThru -ErrorAction silentlyContinue
if ($error) {
    if (![String]::IsNullOrEmpty($LogFileName)) {
        $ErrorLogFileName += ".Error-$(Get-Date -Format FileDateTime).log"
        $error | %{$_.Exception.GetBaseException().Message | Out-File $ErrorLogFileName -Force -Append}
        }
}

if (![String]::IsNullOrEmpty($LogFileName)) {
    $Output | Out-File "$LogFileName-$(Get-Date -Format FileDateTime).log" -Force
    } 
