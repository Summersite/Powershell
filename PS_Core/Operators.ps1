#       POWERSEHLL OPERATORS
#       Operator Definition of PowerShell Syntax

#   	#   The hash key is for comments
#       +	Add
#       –	Subtract
#       *	Multiply 
#       /	Divide
#       %	Modulus (Some call it Modulo) – Means remainder 17 % 5 = 2 Remainder
#       =	equal
#       -   Not	logical not equal
#       !	logical not equal
#       -band	binary and
#       -bor	binary or 
#       -bnot	binary not
#       -replace	Replace (e.g.  "abcde" -replace "b","B") (case insensitive)
#       -ireplace	Case-Insensitive replace (e.g.  "abcde" -ireplace "B","3")
#       -creplace	Case-sensitive replace (e.g.  "abcde" -creplace "B","3")
#       -And	AND (e.g. ($a -ge 5 -AND $a -le 15) )
#       -or	OR  (e.g. ($a -eq "A" -OR $a -eq "B") )
#       -Is	IS type (e.g. $a -Is [int] )
#       -Isnot	IS not type (e.g. $a -Isnot [int] )
#       -as	convert to type (e.g. 1 -as [string] treats 1 as a string )
#       ..	Range operator (e.g.  foreach ($i in 1..10) {$i }  )
#       &	call operator (e.g. $a = "Get-ChildItem" &$a executes Get-ChildItem)
#       .   (dot followed by space)	call operator (e.g. $a = "Get-ChildItem" . $a executes Get-ChildItem in the current scope)
#       .	.Period or .full stop for an objects properties
#       $   CompSys.TotalPhysicalMemory
#       -F	Format operator (e.g. foreach ($p in Get-Process) { "{0,-15} has {1,6} handles" -F  $p.processname,$p.Handlecount } )

#       These are the Operaators for Powershell

#       POWERSHELL’S CONDITIONAL OR COMPARISON OPERATORS
#       Operator	
#       Definition of PowerShell Syntax

#       -lt	Less than
#       -le	Less than or equal to
#       -gt	Greater than
#       -ge	Greater than or equal to
#       -eq	Equal to
#       -ne	Not Equal to
#       -Contains	Determine elements in a group.
#        Contains always returns Boolean $True or $False.
#       -Notcontains	Determine excluded elements in a group
#       This always returns Boolean $True or $False.
#       -Like	Like – uses wildcards for pattern matching
#       -Notlike	Not Like – uses wildcards for pattern matching
#       -Match	Match – uses regular expressions for pattern matching
#       -Notmatch	Not Match – uses regular expressions for pattern matching Bitwise
#       -band	Bitwise AND
#       -bor	Bitwise OR
#       -Is	Is of Type
#       -Isnot	Is not of Type
#        	Other PowerShell Operators
#       if(condition)	If condition (See more on PowerShell’s If)
#       ElseIf(condition)	ElseIf
#       else(condition)	Else
#       >	Redirect, for example, output to text file
#       Example   .\cmdlet > stuff.txt
#       >>	Same as Redirect except it appends to an existing file