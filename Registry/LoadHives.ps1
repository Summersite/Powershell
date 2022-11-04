reg load HKU\student "C:\Users\Student\NtUser.dat"
reg load HKU\Monitor "C:\Users\monitor\NtUser.dat"
reg load HKU\Router "C:\Users\Router\NtUser.dat"
reg load HKU\Internet "C:\Users\Internet\NtUser.dat"
# reg load HKU\Fit "C:\Users\Fit\NtUser.dat"


# Import registry values
# reg import d:\registry\FITDisableTabletMode.reg
reg import d:\registry\StudentDisableTabletMode.reg
reg import d:\registry\MonitorDisableTabletMode.reg
reg import d:\registry\InternetDisableTabletMode.reg
reg import d:\registry\RouterDisableTabletMode.reg

#unload Hives
reg unload HKU\student
reg unload HKU\Monitor
reg unload HKU\Router
reg unload HKU\Internet
# reg unload HKU\Fit
