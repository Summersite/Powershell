$computer='localhost';
$ro=[System.Security.Cryptography.X509Certificates.OpenFlags]"ReadOnly"
$lm=[System.Security.Cryptography.X509Certificates.StoreLocation]"LocalMachine"
$store=new-object System.Security.Cryptography.X509Certificates.X509Store("\\$computer\My",$lm)
$store.Open($ro)
$certificates=$store.Certificates

Get-ChildItem Cert:\ -Recurse