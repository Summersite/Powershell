$PSVersion
$PSVersionTable
help version
Update-Help
help *service*
help get-service
help get-service -Full
help get-service -Online
help get-service -Examples
# search for any occurance of Reboot or restart
help *reboot*
help *restart*
 
# *******************************************************************************

# *** Get Processes 

# ****** DONT RUN THIS ONE IF YOU HAVE VISUAL STUDIO DEBUGGER
get-process  | debug-process 

get-hotfix | Select-Object Description,hotfixid | Format-List
suspend-service -name lanman* -whatif
get-service spooler | stop-service
get-service spooler | start-service
get-wmiobject win32_service -filter "name = 'eNAEP*'"

# list of files in c:\windows -- sort decending --------------- select first 10   (can use the following -last)
# https://technet.microsoft.com/en-us/library/ee176955.aspx
Get-ChildItem c:\windows\*.* | Sort-Object length -descending | Select-Object -first 10

# https://technet.microsoft.com/en-us/library/ee176955.aspx
Get-Process | Select-Object name,id | Format-List | 
 
Get-Process | Select-Object *
Get-Process | Select-Object Name, StartTime | Format-List
Get-Process | Select-Object Name = "WINRM" | format-list
Get-Service | Select-Object name, starttime -Last 20 | format-list
Get-Service winrm | Format-List

#* Get service by name 
get-service | Select-Object | where-object name -eq WINRM

# 1.20 hours into https://www.youtube.com/watch?v=-Ya1dQ1Igkc
Get-Process | Export-Clixml c:\temp\baseline.xml

# *******************************************************************************

# Get the modules that are loaded 
Get-PSSnapin
Get-Command

# load modules - does not work in this version 
Add-PSSnapin windows.serverbackup


# extra modules must be loaded into the powershell session every time you need it - when you start the PS session
# show module loaded into memory
Get-Module
# import module into memory
Import-Module powershellget
Import-Module BitsTransfer
# show command for Module Bitstransfer
get-command -Module bitstransfer
get-command -Module 


# https://www.powershellgallery.com/GettingStarted?section=Get%20Started
Install-PackageProvider -Name NuGet -Force



# install from PowerShell Gallery
Find-Module
Install-Module StartDemo

# Show installed modules from Powershell gallery
Get-installedmodule

#module autodiscovery in version 3 and upwards - will load module for you if you need it



# *******************************************************************************

#   R E M O T I N G
# 1.43 hours into https://www.youtube.com/watch?v=-Ya1dQ1Igkc
 
get-service winrm # is the service that is used for this
# communications to endpoints via one port HTTP 5985 HTTPS 5986  
# is on from win 8 onwards
# enable-psremoting if not activated/loadaed
# can be activated via group policy
help psremoting
# 2 ways of using it
Enter-PSSession -computername 
# 1.49 hours into https://www.youtube.com/watch?v=-Ya1dQ1Igkc



 
# *******************************************************************************
# Using the Where-Object Cmdlet
# https://technet.microsoft.com/en-us/library/ee177028.aspx
Get-Process | Where-Object {$_.handles -gt 200 -or $_.name -eq "svchost"}

# Find Service WINRM by name Different ways of doing it
Get-Service | Where-Object { $_.name -eq "WINRM"}
Get-Service | Where-Object { $_.name -eq "WINRM"}
Get-service -Name "WINRM"

# *******************************************************************************
# test for folder exists
https://technet.microsoft.com/en-us/library/ee177015.aspx

# Returns boolean value
Test-Path HKCU:\Software\Microsoft\Windows\CurrentVersion
Test-Path HKLM:\Software\Wow6432Node\Google\Update
Test-Path c:\Windows

# Returns value True or False 
Test-Path \\naep-dev-001\d$  

# Returns value True or False 
Test-Path i:
# *******************************************************************************
# shows gui of commands for Modules
Show-Command

# shows gui of commands for get-process Module
Show-Command Get-Process
Get-Help Get-Process
# *******************************************************************************
# get all scheduled tasks in task manager
Get-ScheduledTask
# get scheduled task by Taskname
Get-ScheduledTask -TaskName CacheTask
# get scheduled task by Taskname Wildcart 
Get-ScheduledTask -TaskName *Cach*

# *******************************************************************************
# Scheduled tasks
Get-ScheduledTask -TaskName "Start NTP Service for Time Sync"
#Disable Task
Disable-ScheduledTask -TaskName "Start NTP Service for Time Sync"
#Delete Task
unregister-scheduledtask -TaskName "Start NTP Service for Time Sync"

# *******************************************************************************

#**** PAUSE script until key pressed ****** NOT SURE
Write-Host "Press enter to continue and CTRL-C to exit ..."
$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

# *******************************************************************************

# Get answer YES or NO

function Get-SomeInput {
    $input = read-host "Please write yes or no and press Enter"

    switch ($input) `
    {
        'yes' {
            write-host 'You wrote yes'
        }

        'no' {
            write-host 'You wrote no'
        }

        default {
            write-host 'You may only answer yes or no, please try again.'
            Get-SomeInput
        }
    }
}

Get-SomeInput

# *******************************************************************************

Get-Command | where { $_.parameters.keys -contains "erroraction"}

Get-Help about_Preference_Variables -examples

# *********************************************************************************
# ********** This one bypasses the pop up asking for permission to delete or not ** 

$ConfirmPreference = 'None'

unregister-scheduledtask -TaskName "Start NTP Service for Time Sync"

# ********************************************************************************
# ************* Get last boot up time ********************************************
Get-CimInstance -ClassName win32_operatingsystem | select csname, lastbootuptime

# ****************************Get Computer Model ***************************************************
wmic computersystem get model 
# *******************************************************************************


# *******************************************************************************
#*http://jacobbenson.com/?p=654#sthash.BvzaHkGR.p8HGtLrb.dpbs
#* Configuration TestPendingReboot
{ 
    Param( 
        [string]$ComputerName='localhost' 
    ) 
    Import-DSCResource -ModuleName xPendingReboot 
        Node $ComputerName{ 
            xPendingReboot PreTest{ 
                Name = "Check for a pending reboot before changing anything" 
            } 
            LocalConfigurationManager{ 
                RebootNodeIfNeeded = $True 
            } 
    } 
} 
# *******************************************************************************
#* Ask for credentials
$Credential = Get-credential localhost\administrator 

# *******************************************************************************
#*   Password
#* Prompt for a password
$MyEasyPWD = Read-host -Prompt "enter a freaking password"
#* Prompt for a password 
$MyEasyPWDSec = Read-host -Prompt "enter a freaking password - and it will be saved in a securestring"-AsSecureString
#** Get secure password for specific user
Get-Credential
# get-credential
# cmdlet Get-Credential at command pipeline position 1
# Supply values for the following parameters:

# UserName                       Password
# --------                       --------
# jjohannsen System.Security.SecureString

# ***************   Suggestion on using ENV 
$env:COMPUTERNAME
$env:USERNAME
Get-credential $env:COMPUTERNAME\$env:username    #**** Her you will type in the password
#* Saves credentials in varable
$MyCred = Get-Credential $env:COMPUTERNAME\$ENV:username   
#* Get computer name and username
$Mycred.username     #* result 484-LT\jjohannsen
$Mycred.Password     #* result System.Security.SecureString
$Mycred.GetNetworkCredential().Password ### This will retrieve the password in CLEAR text
#* Do action with my credentials
Set-computername -Credential $MyCred
Set-Name -User $Mycred.name -Password $MyCred.Getnetworkcredential().Password

# SAVE CREDENTIALS in a file ************ this could be used if you have a shortcut to powershell to launch it with Administrator elevation
Get-Credential | Export-Clixml .\cred.xml 
# Retrieve password from a file
$Cred - Import-Clixml .\cred.cml

#***************** Hack users within domain

https://www.youtube.com/watch?v=XpHgSHQZNpU#t=105.805421

# ********************************************************** Secure keys ******************************************************************
http://www.adminarsenal.com/admin-arsenal-blog/secure-password-with-powershell-encrypting-credentials-part-1/
# ********************************************************** Secure keys ******************************************************************
https://gallery.technet.microsoft.com/scriptcenter/PowerShell-Credentials-d44c3cde
# ********************************************************** Secure keys ******************************************************************
https://blogs.technet.microsoft.com/robcost/2008/05/01/powershell-tip-storing-and-using-password-credentials/
# ********************************************************** Secure keys ******************************************************************

# ********************************************************** Secure keys ******************************************************************

# ********************************************************** Secure keys ******************************************************************

# ********************************************************** Secure keys ******************************************************************

# ********************************************************** Secure keys ******************************************************************










