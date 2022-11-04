#* FileName:  FixTouchPadRightClick.ps1
#*=============================================================================
#* Created:		[2016/09/16]
#* Author:		Jimmy Johannsen
#* Updated:     [2016/11/30 Jimmy Johannsen]
#* Arguments:	
#*=============================================================================
#* Purpose: Import registrykeys
#*=============================================================================


function checkExists
{
    if(!(Test-Path $args[0]))
    {
        "Unable to locate " + $args[0] + " in FixTouchPadRightClick.ps1"
        Exit 1
    }
}


# set source Path
$SrcRegistryKeys  = "C:\Windows\Temp\eupdownload\eNAEPUpdater\STEP21-TouchPad\"


# Load User Registry Hives
Write-Host Loading Registry Hives
reg load HKU\Router "C:\Users\Router\NtUser.dat"
reg load HKU\Monitor "C:\Users\Monitor\NtUser.dat"
reg load HKU\student "C:\Users\Student\NtUser.dat"

Checkexists $SrcRegistryKeys

try
{

    #Import Registry values
    Write-Host Importing Registry values
    reg import "$SrcRegistryKeys\FixTouchPadRightClickRouter.reg"
    reg import "$SrcRegistryKeys\FixTouchPadRightClickMonitor.reg"
    reg import "$SrcRegistryKeys\FixTouchPadRightClickStudent.reg"

    #unload Hives
    Write-Host Unloading Hives
    reg unload HKU\Router
    reg unload HKU\Monitor
    reg unload HKU\student
}
catch
{
"Error during import of Registry Keys"
exit 1
}
# **************************************** End Of Script *******************************************************