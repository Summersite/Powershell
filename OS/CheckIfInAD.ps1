function Test-DomainNetworkConnection
{
    # Returns $true if the computer is attached to a network where it has a secure connection
    # to a domain controller
    # 
    # Returns $false otherwise

    # Get operating system  major and minor version
    $strOSVersion = (Get-WmiObject -Query "Select Version from Win32_OperatingSystem").Version
    $arrStrOSVersion = $strOSVersion.Split(".")
    $intOSMajorVersion = [UInt16]$arrStrOSVersion[0]
    if ($arrStrOSVersion.Length -ge 2)
    {
        $intOSMinorVersion = [UInt16]$arrStrOSVersion[1]
    } `
    else
    {
        $intOSMinorVersion = [UInt16]0
    }

    # Determine if attached to domain network
    if (($intOSMajorVersion -gt 6) -or (($intOSMajorVersion -eq 6) -and ($intOSMinorVersion -gt 1)))
    {
        # Windows 8 / Windows Server 2012 or Newer
        # First, get all Network Connection Profiles, and filter it down to only those that are domain networks
        $domainNetworks = Get-NetConnectionProfile | Where-Object {$_.NetworkCategory -eq "Domain"}
    } `
    else
    {
        # Windows Vista, Windows Server 2008, Windows 7, or Windows Server 2008 R2
        # (Untested on Windows XP / Windows Server 2003)
        # Get-NetConnectionProfile is not available; need to access the Network List Manager COM object
        # So, we use the Network List Manager COM object to get a list of all network connections
        # Then we get the category of each network connection
        # Categories: 0 = Public; 1 = Private; 2 = Domain; see: https://msdn.microsoft.com/en-us/library/windows/desktop/aa370800(v=vs.85).aspx

        $domainNetworks = ([Activator]::CreateInstance([Type]::GetTypeFromCLSID([Guid]"{DCB00C01-570F-4A9B-8D69-199FDBA5723B}"))).GetNetworkConnections() | `
            ForEach-Object {$_.GetNetwork().GetCategory()} | Where-Object {$_ -eq 2}
    }
    return ($domainNetworks -ne $null)
}