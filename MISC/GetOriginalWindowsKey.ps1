# 2 different ways of getting the Windows original Product key - works on Windows 10

wmic path softwarelicensingservice get OA3xOriginalProductKey

powershell "(Get-WmiObject -query ‘select * from SoftwareLicensingService’).OA3xOriginalProductKey"