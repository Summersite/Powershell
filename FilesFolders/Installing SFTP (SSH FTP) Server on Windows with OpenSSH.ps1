# Setup openSSH windows 2012R2
# http://woshub.com/installing-sftp-ssh-ftp-server-on-windows-server-2012-r2/

# goto c:\openssh\
# install-sshd.ps1
<#

add c:\OpenSSH-Win  to path

PS C:\Users\Administrator> cd\
PS C:\> cd .\OpenSSH-Win
PS C:\OpenSSH-Win> .\install-sshd.ps1
[SC] SetServiceObjectSecurity SUCCESS
[SC] ChangeServiceConfig2 SUCCESS
[SC] ChangeServiceConfig2 SUCCESS
sshd and ssh-agent services successfully installed
PS C:\OpenSSH-Win>


Your identification has been saved in vhost01ssh.
Your public key has been saved in vhost01ssh.pub.
The key fingerprint is:
SHA256:69G2tQXI51CuBadwGrkwASrT1WLqI0LxIXcDmeL+BBo administrator@VHOST01
The key's randomart image is:
+---[RSA 3072]----+
|   .*o.          |
| = Boo.. .       |
|+ Ooo.+ + o o    |
|E*..   o B B     |
|+o.     S = =    |
|+.o.     o * .   |
|..o.    o + o .  |
|   .   . o o o   |
|        . . .    |
+----[SHA256]-----+
PS C:\OpenSSH-Win>
#>


Set-Service -Name sshd -StartupType ‘Automatic’
Start-Service sshd

restart-computer

New-NetFirewallRule -Protocol TCP -LocalPort 22 -Direction Inbound -Action Allow -DisplayName SSH

