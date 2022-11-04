# replace server name
param (
    [string[]]$ComputerName = '484-lt'
)
foreach ($Computer in $ComputerName) {
    $Results = @()
    ([adsi]"WinNT://$Computer").psbase.Children | ? {$_.SchemaClassName -eq 'Group'} | % {
        foreach ($Member in $($_.psbase.invoke('members'))) {
            $Results += New-Object -TypeName PSCustomObject -Property @{
                name = $Member.GetType().InvokeMember("Name", 'GetProperty', $null, $Member, $null) 
                class = $Member.GetType().InvokeMember("Class", 'GetProperty', $null, $Member, $null) 
                path = $Member.GetType().InvokeMember("ADsPath", 'GetProperty', $null, $Member, $null)
                group = $_.psbase.name
            } | ? {($_.Class -eq 'User') -and ([regex]::Matches($_.Path,'/').Count -eq 4)}
        }
    }
    $Results | Group-Object Name | Select-Object Name,@{name='Group';expression={$_.Group | % {$_.Group}}},@{name='Computer';expression={$Computer}}
}