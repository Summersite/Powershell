function current-time {

    get-date -DisplayHint Time

}

function current-date {

    get-date -DisplayHint date

}
cls

write-host -ForegroundColor Gray "Today's Date is" | current-date
# current-date

write-host -ForegroundColor Gray "And the time is"

current-time 