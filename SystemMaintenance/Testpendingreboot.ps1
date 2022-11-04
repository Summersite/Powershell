Configuration TestPendingReboot
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