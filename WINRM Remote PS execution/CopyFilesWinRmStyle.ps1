
# Powershell for remote execution on host 
# Winrm needs to be running on the host that needs to run the Powershell = Run command WimRM Quickconfig on remote host

# To start a PS Session on a Remotoe Computer
# Enter-PSSession naep-vhost6 -Credential $cred


Robocopy 'C:\VM''s\' \\naep-vhost6\d$\Temp /E /Z /L /log:test /TEE

$cred = Get-Credential -Username "naepims\jjohannsenda" -Message "Type"
invoke-command -ComputerName naep-vhost6 {Get-UICulture} -Credential $cred


$credential = Get-Credential
$sesh = new-pssession -computername $server -credential $credential -authentication Credssp
$scriptblock = $ExecutionContext.InvokeCommand.NewScriptBlock("Robocopy 'C:\VM''s\' \\naep-vhost6\d$\Temp /E /Z /NP /log:test /TEE")
invoke-command -session $sesh -scriptblock $scriptblock

