#Requires -Version 2.0

<#
.SYNOPSIS
    Lists local computers' users.
.DESCRIPTION
    Lists local computers' users. By default it lists only the enabled users.
.EXAMPLE
    No parameters needed.
    Lists enabled users on the local computer.
.EXAMPLE
     -AllUsers
    Lists enabled and disabled users on the local computer.
.EXAMPLE
    PS C:\> List-Users.ps1 -AllUsers
    Lists enabled and disabled users on the local computer.
.OUTPUTS
    System.Management.Automation.SecurityAccountsManager.LocalUser[]
.NOTES
    Minimum OS Architecture Supported: Windows 7, Windows Server 2012
    Release Notes:
    Initial Release
.COMPONENT
    ManageUsers
#>

[CmdletBinding()]
param (
    # Will return disabled users as well as enabled users
    [Switch]
    $AllUsers
)

begin {
    Write-Output "Starting List Users"
}

process {
    # If we are running powershell under a 32bit OS or running a 32bit version of powershell
    # or we don't have access to Get-LocalUser
    if (
        [Environment]::Is64BitProcess -ne [Environment]::Is64BitOperatingSystem -or
            (Get-Command -Name "Get-LocalUser" -ErrorAction SilentlyContinue).Count -eq 0
    ) {
        # Get users from net.exe user
        $Data = $(net.exe user) | Select-Object -Skip 4
        # Check if the command ran the way we wanted and the exit code is 0
        if ($($Data | Select-Object -last 2 | Select-Object -First 1) -like "*The command completed successfully.*" -and $LASTEXITCODE -eq 0) {
            # Process the output and get only the users
            $Users = $Data[0..($Data.Count - 3)] -split '\s+' | Where-Object { -not $([String]::IsNullOrEmpty($_) -or [String]::IsNullOrWhiteSpace($_)) }
            # Loop through each user
            $Users | ForEach-Object {
                # Get the Account active property look for a Yes
                $Enabled = $(net.exe user $_) | Where-Object {
                    $_ -like "Account active*" -and
                    $($_ -split '\s+' | Select-Object -Last 1) -like "Yes"
                }
                # Output Name and Enabled almost like how Get-LocalUser displays it's data
                [PSCustomObject]@{
                    Name    = $_
                    Enabled = if ($Enabled -like "*Yes*") { $true }else { $false }
                }
            } | Where-Object { if ($AllUsers) { $_.Enabled }else { $true } }
        }
        else {
            exit 1
        }
    }
    else {
        try {
            if ($AllUsers) {
                Get-LocalUser
            }
            else {
                Get-LocalUser | Where-Object { $_.Enabled -eq $true }
            }
        }
        catch {
            Write-Error $_
            exit 1
        }
    }
}

end {
    Write-Output "Completed List Users"
}