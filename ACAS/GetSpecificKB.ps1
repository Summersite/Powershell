# Powershell Script location .COM \\Mediashare\apps\ahlta\jimmy\powershell

Get-HotFix -Id KB4470199 # this is for September ACAS for sure
Get-Hotfix -Id KB4578013 # this is for September ACAS for sure

# Provides protections against a variant (CVE-2019-1125) of the Spectre Variant 1 speculative execution side channel vulnerability.
Get-Hotfix -Id KB4507448 # See ACAS report summary in OneNote

# ADV180012 | Microsoft Guidance for Speculative Store Bypass
# https://portal.msrc.microsoft.com/en-US/security-guidance/advisory/ADV180012
Get-Hotfix -Id KB4480963 # See ACAS report summary in OneNote
Get-Hotfix -Id KB4480964 # See ACAS report summary in OneNote


# ADV180002 | Guidance to mitigate speculative execution side-channel vulnerabilities
# https://portal.msrc.microsoft.com/en-US/security-guidance/advisory/ADV180002
Get-Hotfix -Id KB4338815 # See ACAS report summary in OneNote
Get-Hotfix -Id KB4338824 # See ACAS report summary in OneNote

# ADV190013 | Microsoft Guidance to mitigate Microarchitectural Data Sampling vulnerabilities
# https://portal.msrc.microsoft.com/en-us/security-guidance/advisory/adv190013
Get-Hotfix -Id KB4499151 # See ACAS report summary in OneNote
Get-Hotfix -Id KB4499165 # See ACAS report summary in OneNote

# CVE-2019-1125 | Windows Kernel Information Disclosure Vulnerability
# https://portal.msrc.microsoft.com/en-US/security-guidance/advisory/CVE-2019-1125
Get-Hotfix -Id KB4407448 # See ACAS report summary in OneNote  doesn’t exist in windows update
Get-Hotfix -Id KB4507457 # See ACAS report summary in OneNote
