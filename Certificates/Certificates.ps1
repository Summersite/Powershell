# **************** https://adamtheautomator.com/windows-certificate-manager/ *******************************
#
# **************** By Physical Store **********************
# Using the Get-ChildItem PowerShell cmdlet, you can enumerate all of the keys and values inside of the 
# parent HKCU:\Software\Microsoft\SystemCertificates\CA\Certificates\ registry key path.
# The below command will enumerate all of the currently-logged-in user’s certificates in the Intermediate Certification Authorities logical store.

Get-ChildItem -Path HKCU:\Software\Microsoft\SystemCertificates\CA\Certificates\ | select -first 5

#> Another common store is, the Personal store. Your certificates for this store are located on the file system rather than the Registry. 
# In the following commands we will show these different physical paths and their purposes.
#< Each file in the directory, returned by the command below, corresponds to a certificate installed in the Personal current user store.

Get-ChildItem -Path $env:APPDATA\Microsoft\SystemCertificates\My\Certificates\

# Each file returned in the below command is a reference to the object for a private key created by the Key Storage Provider (KSP). 
# The file name corresponds to the Subject Key Identifier of the certificate. Each private key you install will have a corresponding file added.

Get-ChildItem -Path $env:APPDATA\Microsoft\SystemCertificates\My\Keys\

# Each file in the directory returned by the below command is the unique container for the encrypted private key created by the KSP. 
# There is no direct relationship between the file name and the certificate, but the file is the target of the pointer in the earlier command.

Get-ChildItem -Path $env:APPDATA\Microsoft\Crypto\Keys

# **************** By Logical Store **********************

# When you are working with certificates you will need a way to filter and select certificates to perform specific operations against. 
# Most of the time you will filter and select certificates based on the value of a specific extension.
# For the following examples you need to start by listing all installed certificates in the root CA store.

Get-ChildItem -Path Cert:\CurrentUser\Root\

# Common extensions are already available as properties of the certificate objects. 
# In the below example you are using Get-Member to list all the properties of the returned objects.

Get-ChildItem -Path Cert:\CurrentUser\Root\ | Get-Member -MemberType Properties

# The existing ScriptProperties available on the object show examples for interfacing with these. 
# In the below command you will pull the Key Usages manually to see this relationship.
# You pass it a boolean value (e.g. $true) to identify whether we want the returned object to be single-line or multi-line.

((Get-ChildItem -Path Cert:\CurrentUser\Root\ | select -First 1).Extensions | Where-Object {$_.Oid.FriendlyName -eq "Key Usage"}).format($true)


# The Thumbprint value is set as a PowerShell variable and used to select the specific certificate in the below commands.
# Cert:\CurrentUser\Root\ refers to Certificate - Current user -> Trusted Root Certification Authorities -> Certificates

$thumb = "9a10d5fdc4a4222e5c49aaccda40e2d0672e1208"
Get-ChildItem -Path Cert:\CurrentUser\Root\ | Where-Object {$_.Thumbprint -eq $thumb}

# Create Sef-signed certificate
# Let’s now create a self-signed certificate in the Current User and the Local Machine stores to use in examples for the next steps.
# In the example below, PowerShell is generating a public and private key pair, a self-signed certificate, and installing them all into the appropriate certificate stores.

New-SelfSignedCertificate -Subject 'User-Test' -CertStoreLocation 'Cert:\CurrentUser\My'
New-SelfSignedCertificate -Subject 'Computer-Test' -CertStoreLocation 'Cert:\LocalMachine\My'



#