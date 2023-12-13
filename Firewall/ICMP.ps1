#enable ping IPv4 ingress to server 
# https://theitbros.com/allow-ping-icmp-echo-requests-on-windows-firewall/
Enable-NetFirewallRule -displayName "File and Printer Sharing (Echo Request - ICMPv4-In)"