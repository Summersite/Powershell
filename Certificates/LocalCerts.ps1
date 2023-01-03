# Define where OpenSSL is installed
$openSSLDir = "C:\Program Files\OpenSSL\bin"

# Define the domain we're generating the CSR for
$commonName = Read-Host -Prompt "Provide the domain you're generating a certificate for"

# Define the default parameters on the certificate
$email = 'jimmy_johannsen@outlook.com'
$country = 'US'
$state = 'Virginia'
$locality = 'Front Royal'
$orgUnit = 'HomeIT'
$org = 'Local, Inc'
$wwwSAN = "www.$commonName"

# Build the config file
$configFile = @"
# -------------- BEGIN CONFIG --------------
HOME = .
oid_section = new_oids
[ new_oids ]
[ req ]
default_days = 1095
distinguished_name = req_distinguished_name
encrypt_key = no
string_mask = nombstr
req_extensions = v3_req # Extensions to add to certificate request
[ req_distinguished_name ]
countryName = Country Name (2 letter code)
countryName_default = $country
stateOrProvinceName = State or Province Name (full name)
stateOrProvinceName_default = $state
localityName = Locality Name (eg, city)
localityName_default = $locality
organizationalUnitName  = Organizational Unit Name (eg, section)
organizationalUnitName_default  = $orgUnit
organizationName = Organization Name (eg, company)
organizationName_default = $org
commonName = Your common name (eg, domain name)
commonName_default = $commonName
emailAddress = Contact email address
emailAddress_default = $email
commonName_max = 64
[ v3_req ]
subjectAltName= @alt_names
[alt_names]
DNS.1 = $wwwSAN
DNS.2 = $commonName
# -------------- END CONFIG --------------
"@

# Write it out to the temp folder
$configFile | Out-File -FilePath $env:TEMP\csrconf.cnf -Force -Encoding ascii

# Change directory
Set-Location -Path $openSSLDir

# Generate the key and csr
Start-Process .\openssl.exe -Argumentlist "req -sha256 -new -nodes -keyout C:\Temp\$commonName-private.txt -out C:\Temp\$commonName-csr.txt -newkey rsa:2048 -config $env:TEMP\csrconf.cnf"