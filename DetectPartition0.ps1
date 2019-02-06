if (Get-Disk -Number 0 | ?{$_.BusType -eq "USB"})
{
    "rescan" | diskpart;
    if (Get-Disk -Number 0 | ?{$_.BusType -eq "USB"}) {Throw "Nope, didn't work"}
}  