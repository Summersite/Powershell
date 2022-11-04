$VerbosePreference = "Continue"
Start-Transcript -Path "C:\Windows\Temp\ForceLoadProfiles.txt" -Force -ea 4

Add-Type -Namespace Import -Name Profile -MemberDefinition @'
[StructLayout(LayoutKind.Sequential)]
public struct ProfileInfo
{
    public int dwSize;
    public int dwFlags;
    [MarshalAs(UnmanagedType.LPTStr)]
    public string lpUserName;
    [MarshalAs(UnmanagedType.LPTStr)]
    public string lpProfilePath;
    [MarshalAs(UnmanagedType.LPTStr)]
    public string lpDefaultPath;
    [MarshalAs(UnmanagedType.LPTStr)]
    public string lpServerName;
    [MarshalAs(UnmanagedType.LPTStr)] 
    public string lpPolicyPath;
    public IntPtr hProfile;
} 

public enum SECURITY_IMPERSONATION_LEVEL
{
     SecurityAnonymous,
     SecurityIdentification,
     SecurityImpersonation,
     SecurityDelegation
}

public const int PI_NOUI = 0x1;

public enum LogonType
{
    LOGON32_LOGON_INTERACTIVE = 2,
    LOGON32_LOGON_NETWORK = 3,
    LOGON32_LOGON_BATCH = 4,
    LOGON32_LOGON_SERVICE = 5,
    LOGON32_LOGON_UNLOCK = 7,
    LOGON32_LOGON_NETWORK_CLEARTEXT = 8,
    LOGON32_LOGON_NEW_CREDENTIALS = 9,
}

public enum LogonProvider
{
    LOGON32_PROVIDER_DEFAULT = 0,
    LOGON32_PROVIDER_WINNT35 = 1,
    LOGON32_PROVIDER_WINNT40 = 2,
    LOGON32_PROVIDER_WINNT50 = 3
}

[DllImport("advapi32.dll", CharSet = CharSet.Auto, SetLastError = true)]
public static extern int DuplicateToken(IntPtr hToken, int impersonationLevel, out IntPtr hNewToken);

[DllImport("userenv.dll", CallingConvention = CallingConvention.Winapi, SetLastError = true, CharSet = CharSet.Auto)]
public static extern bool LoadUserProfile(IntPtr hToken, ref ProfileInfo lpProfileInfo);

[DllImport("Userenv.dll", CallingConvention = CallingConvention.Winapi, SetLastError = true, CharSet = CharSet.Auto)]
public static extern bool UnloadUserProfile(IntPtr hToken, IntPtr lpProfileInfo);

[DllImport("advapi32.dll", SetLastError = true)]
public static extern bool LogonUser(string user, string domain, string password, int logonType, int logonProvider, out IntPtr token);

[DllImport("kernel32.dll", SetLastError = true)]
public static extern bool CloseHandle(IntPtr handle);
'@

$tokenHandle = 0
$Domain = "."

$Accounts = @{
    "Internet" = 'Time2connect!'
    "Monitor" = 'Time2observe'
    "Student" = 'Time2assess!'
    "Router" = 'Time2network!'
    "Review" = 'Review$2019'
    "eUPDate" = 'Time2launch!'
}

[int]$SecurityImpersonation = 2;
[int]$TokenType = 1;

$Accounts.GetEnumerator() |%{
    [IntPtr]$tokenDuplicate = [IntPtr]::Zero;
    Write-Verbose "Loading account $($_.Key)"
    $returnValue = [Import.Profile]::LogonUser($_.Key, $Domain, $_.Value, [Import.Profile+LogonType]::LOGON32_LOGON_INTERACTIVE, [Import.Profile+LogonProvider]::LOGON32_PROVIDER_DEFAULT, [ref]$tokenHandle)
    if (!$returnValue) {
        $errCode = [System.Runtime.InteropServices.Marshal]::GetLastWin32Error();
        Write-Warning [System.ComponentModel.Win32Exception]$errCode
    } else 
    {
        Write-Verbose "Duplicating token"
        $returnValue = [Import.Profile]::DuplicateToken($tokenHandle, [Import.Profile+SECURITY_IMPERSONATION_LEVEL]::SecurityImpersonation, [ref]$tokenDuplicate)
        if (!$returnValue) {
            $errCode = [System.Runtime.InteropServices.Marshal]::GetLastWin32Error();
            throw [System.ComponentModel.Win32Exception]$errCode
        } else 
        {
            Write-Verbose "Loading profile"
            [Import.Profile+ProfileInfo]$profileInfo = New-Object Import.Profile+ProfileInfo
            $profileInfo.lpUserName = $_.Key
            $profileInfo.dwFlags = [Import.Profile]::PI_NOUI;
            $profileInfo.dwSize = [System.Runtime.InteropServices.Marshal]::SizeOf([type][Import.Profile+ProfileInfo]);

            if (![Import.Profile]::LoadUserProfile($tokenDuplicate, [ref]$profileInfo)){
                $errCode = [System.Runtime.InteropServices.Marshal]::GetLastWin32Error();
                throw [System.ComponentModel.Win32Exception]$errCode
            } else 
            {
                if (![Import.Profile]::UnloadUserProfile($tokenDuplicate, $profileInfo.hProfile)){
                    $errCode = [System.Runtime.InteropServices.Marshal]::GetLastWin32Error();
                    Write-Host "failed a call to UnLoadUserProfile with error code: $errCode"
                    throw [System.ComponentModel.Win32Exception]$errCode
                }
            }
            [void][Import.Profile]::CloseHandle($tokenDuplicate)
        }
        [void][Import.Profile]::CloseHandle($tokenHandle)
    }
}
Stop-Transcript -ea 4 
