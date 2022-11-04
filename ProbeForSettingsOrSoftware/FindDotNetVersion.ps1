#https://docs.microsoft.com/en-us/dotnet/framework/migration-guide/how-to-determine-which-versions-are-installed

<#
.NET Framework version	Minimum value
.NET Framework 4.5	    378389
.NET Framework 4.5.1	378675
.NET Framework 4.5.2	379893
.NET Framework 4.6	    393295
.NET Framework 4.6.1	394254
.NET Framework 4.6.2	394802
.NET Framework 4.7	    460798
.NET Framework 4.7.1	461308
.NET Framework 4.7.2	461808
.NET Framework 4.8	    528040





#>



(Get-ItemProperty "HKLM:SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full").Release -ge 394802