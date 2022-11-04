function current-time {

    get-date -DisplayHint Time

}

function current-date {

    get-date -DisplayHint date

}
cls

write-host -ForegroundColor Gray "Today's Date is" 
current-date

 write-host -ForegroundColor Gray "And the time is" | current-time




$computer = Get-Content C:\temp\computer.txt
 
foreach ($c in $computer) {
 
if (Test-Connection -ComputerName $c -Count 1 -Quiet ) 
{
Copy-Item C:\temp\dirtest.txt -Destination \\$c\w$\test\ -ErrorAction SilentlyContinue -ErrorVariable A
     if($A) {Write-Output "There is no copy on the server $c" | out-file C:\temp\copy_log.txt -Append}
}
else
{ 
Write-Output "Computer $c is Offline" | Out-File W:\logfiles\copy_log.txt -Append
}
}