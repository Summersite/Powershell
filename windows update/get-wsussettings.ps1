Write-Host "" 
$WUSettingsNoAutoUpdate = "" 
$WUSettingsNoAutoUpdate = (Get-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate\AU" -ErrorAction SilentlyContinue).NoAutoUpdate 
$WUSettingsAUOptions = "" 
$WUSettingsAUOptions = (Get-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate\AU" -ErrorAction SilentlyContinue).AUOptions 
$WSUSSetting = "" 
$WSUSSetting = (Get-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate\AU" -ErrorAction SilentlyContinue).UseWUServer 
$WSUSSettingWUServer = "" 
$WSUSSettingWUServer = (Get-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate" -ErrorAction SilentlyContinue).WUServer 
$WUfBSettingBranchLocal = "" 
$WUfBSettingFULocal = "" 
$WUfBSettingQULocal = "" 
$WUfBSettingBranchLocal = (Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" -ErrorAction SilentlyContinue).BranchReadinessLevel 
$WUfBSettingFULocal = (Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" -ErrorAction SilentlyContinue).DeferFeatureUpdatesPeriodInDays 
$WUfBSettingQULocal = (Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" -ErrorAction SilentlyContinue).DeferQualityUpdatesPeriodInDays 
$WUfBSettingBranch = "" 
$WUfBSettingFU = "" 
$WUfBSettingQU = "" 
$WUfBSettingFUdays = "" 
$WUfBSettingQUdays = "" 
$WUfBSettingBranch = (Get-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -ErrorAction SilentlyContinue).BranchReadinessLevel 
$WUfBSettingFU = (Get-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -ErrorAction SilentlyContinue).DeferFeatureUpdates 
$WUfBSettingQU = (Get-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -ErrorAction SilentlyContinue).DeferQualityUpdates 
$WUfBSettingFUdays = (Get-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -ErrorAction SilentlyContinue).DeferFeatureUpdatesPeriodInDays 
$WUfBSettingQUdays = (Get-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -ErrorAction SilentlyContinue).DeferQualityUpdatesPeriodInDays 
 
$WUfBSettingTargetReleaseVersion = (Get-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -ErrorAction SilentlyContinue).TargetReleaseVersion 
$WUfBSettingTargetReleaseVersionInfo = (Get-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -ErrorAction SilentlyContinue).TargetReleaseVersionInfo 
 
$ConfigMgrClient = "" 
$ConfigMgrClient = (Get-WmiObject -Query "Select * from __Namespace WHERE Name='CCM'" -Namespace root -ErrorAction SilentlyContinue) 
 
if ($WSUSSetting -eq "1") { 
    $EffectiveWSUS = "enabled" 
} else { 
    $EffectiveWSUS = "disabled" 
} 
if ((($WUfBSettingFULocal -eq "0") -and ($WUfBSettingQULocal -eq "0")) -or (($WUfBSettingFULocal.Length -eq 0) -and ($WUfBSettingQULocal.Length -eq 0))) { 
    $EffectiveWUfBLocal = "disabled" 
} else { 
    $EffectiveWUfBLocal = "enabled" 
} 
if (($WUfBSettingFU -eq "1") -or ($WUfBSettingQU -eq "1")) { 
    $EffectiveWUfBPolicy = "enabled" 
} else { 
    $EffectiveWUfBPolicy = "disabled" 
} 
if (($EffectiveWSUS -eq "enabled") -and ($EffectiveWUfBLocal -eq "enabled") -and ($EffectiveWUfBPolicy -eq "enabled")) { 
    $EffectiveWSUS = "* WSUS and WUfB settings are mixed. This state is not recommended. " 
    $EffectiveWUfBLocal = "* this setting has no effect. " 
    $EffectiveWUfBPolicy = "* WSUS and WUfB settings are mixed. This state is not recommended. " 
} elseif (($EffectiveWSUS -eq "enabled") -and ($EffectiveWUfBLocal -eq "enabled")) { 
    $EffectiveWSUS = "* WSUS and WUfB settings are mixed. This state is not recommended. " 
    $EffectiveWUfBLocal = "* WSUS and WUfB settings are mixed. This state is not recommended. " 
    $EffectiveWUfBPolicy = "" 
} elseif (($EffectiveWSUS -eq "enabled") -and ($EffectiveWUfBPolicy -eq "disabled")) { 
    $EffectiveWSUS = "* This setting is effective. " 
    $EffectiveWUfBLocal = "" 
    $EffectiveWUfBPolicy = "" 
} elseif (($EffectiveWSUS -eq "enabled") -and ($EffectiveWUfBPolicy -eq "enabled")) { 
    $EffectiveWSUS = "* WSUS and WUfB settings are mixed. This state is not recommended. " 
    $EffectiveWUfBLocal = "" 
    $EffectiveWUfBPolicy = "* WSUS and WUfB settings are mixed. This state is not recommended. " 
} elseif (($EffectiveWUfBLocal -eq "enabled") -and ($EffectiveWUfBPolicy -eq "enabled")) { 
    $EffectiveWSUS = "" 
    $EffectiveWUfBLocal = "* this setting has no effect. " 
    $EffectiveWUfBPolicy = "* This setting is effective. " 
} else { 
    $EffectiveWSUS = "" 
    $EffectiveWUfBLocal = "" 
    $EffectiveWUfBPolicy = "" 
} 
 
# Check WU Settings 
if ($WUSettingsNoAutoUpdate.Length -eq 0) { 
    Write-Host "Windows Update (Policies): Not Configured (Windows 10 default is automatic)" 
} else { 
      if ($WUSettingsNoAutoUpdate -eq "1") { 
        Write-Host "Windows Update (Policies): Manual (Disabled)" 
    } elseif ($WUSettingsAuOptions -eq "3") { 
        Write-Host "Windows Update (Policies): Download only" 
    } elseif ($WUSettingsAuOptions -eq "4") { 
        Write-Host "Windows Update (Policies): Automatic" 
    } else { 
        Write-Host "Windows Update (Policies): Custom" 
    } 
    Write-Host "  (This setting is in Computer Configuration\Adminisrative Template\Windows Component\Windows Update\Configure Automatic Updates. )" 
 
} 
Write-Host "" 
# Check WSUS Settings 
if ($WSUSSetting.Length -eq 0) { 
    Write-Host "WSUS Client: Not Configured" 
} else { 
    if ($WSUSSetting -eq "0") { 
        Write-Host "WSUS Client: Disabled" 
    } else { 
        Write-Host "WSUS Client: Enabled" 
        Write-Host "  WSUS Server:" $WSUSSettingWUServer 
    } 
    Write-Host "  ("$EffectiveWSUS"This setting is in Computer Configuration\Adminisrative Template\Windows Component\Windows Update\Specify intranet Microsoft update service location.)" 
} 
Write-Host "" 
# Check Local WUfB Settings 
if ((($WUfBSettingFULocal -eq "0") -and ($WUfBSettingQULocal -eq "0") -and ($WUfBSettingBranchLocal -eq "16")) -or (($WUfBSettingFULocal.Length -eq 0) -and ($WUfBSettingQULocal.Length -eq 0)) -or ($WUfBSettingBranchLocal.Length -eq 0)) { 
    Write-Host "Windows Update for Business (Settings app): Not Configured" 
} else { 
    Write-Host "Windows Update for Business (Settings app): Enabled" 
    if ($WUfBSettingBranchLocal -eq "16") { 
        Write-Host "  Update Channel: Semi-Annual Channel (SAC)"  
        } elseif ($WUfBSettingBranchLocal -eq "32") { 
        Write-Host "  Update Channel: SAC-T (for 1809 and below only)"  
    } else { 
        Write-Host "  Update Channel: Preview Build"  
    } 
    Write-Host "  After a feature update is released, defer receiving it for this days (ver 1909 or before):" $WUfBSettingFULocal 
    Write-Host "  After a quality update is released, defer receiving it for this days (ver 1909 or before):" $WUfBSettingQULocal 
    Write-Host "  ("$EffectiveWUfBLocal"These settings are in Settings > Update & Security > Windows Update > Advanced Options > Chose when updates are installed. (Hidden in WSUS client))" 
} 
Write-Host "" 
# Check WUfB Settings Policies 
if (($WUfBSettingFU -eq "1") -or ($WUfBSettingQU -eq "1") -or ($WUfBSettingTargetReleaseVersion -eq "1")) { 
    Write-Host "Windows Update for Business (Policies): Enabled" 
        if ($WUfBSettingBranch.Length -eq 0) { 
        Write-Host "  Update Channel: Not Confiured" 
        } else { 
        if ($WUfBSettingBranch -eq "16") { 
            Write-Host "  Update Channel: Semi-Annual Channel (SAC)"  
        } elseif ($WUfBSettingBranch -eq "32") { 
            Write-Host "  Update Channel: SAC-T (for 1809 and below only)"  
        } else { 
            Write-Host "  Update Channel: Preview Build" 
        } 
        } 
        if ($WUfBSettingFU.Length -eq 0){ 
            Write-Host "  After a feature update is released, defer receiving it for this days: Not Confugired" 
        } else {  
            Write-Host "  After a feature update is released, defer receiving it for this days:" $WUfBSettingFUdays 
        } 
    if ($WUfBSettingQU.Length -eq 0){ 
        Write-Host "  After a quality update is released, defer receiving it for this days: Not Configured" 
    } else { 
        Write-Host "  After a quality update is released, defer receiving it for this days:" $WUfBSettingQUdays 
    } 
    if ($WUfBSettingTargetReleaseVersionInfo.Length -eq 0){ 
        Write-Host "  Targeted feature update version (ver 1803 or later): Not Configured" 
    } else { 
        Write-Host "  Targeted feature update version (ver 1803 or later): " $WUfBSettingTargetReleaseVersionInfo 
        } 
    Write-Host "  ("$EffectiveWUfBPolicy"These settings are in Computer Configuration\Adminisrative Template\Windows Component\Windows Update\Windows Update for Business.)" 
} else { 
    Write-Host "Windows Update for Business (Policies): Not Configured" 
} 
 
Write-Host "" 
# Check ConfigMgr Client 
if (($ConfigMgrClient.Length -ne 0) -and (Test-Path "C:\Windows\CCMSETUP")) { 
    Write-Host "***************************************************************************" 
    Write-Host "* This device may be managed by Microsoft Endpoint Configuration Manager. *" 
    Write-Host "***************************************************************************" 
} 
Write-Host "" 
$WinVer = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion").ReleaseId 
$WinBuild = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion").CurrentBuild 
$WinRev = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion").UBR 
Write-Host "Current update status: version"$WinVer", build" $WinBuild"."$WinRev 
Write-Host "" 
Write-Host "Note 1: This script does not support the identification of devices managed by Microsoft Intune or other update tools." 
if ($WinVer.Substring(0,1) -eq "2") { 
    Write-Host "Note 2: The deferral option for Windows Update for Business (Settings app) is Discontinued in Windows 10 ver 2004." 
} 
Write-Host ""