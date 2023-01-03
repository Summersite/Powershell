# This is the function I used to renew a certificate that was generated from an Active Directory template.

function Renew-Certificate {
  [CmdletBinding()]
  Param([Parameter(Mandatory=$true, ValueFromPipeline=$false)] [ValidateNotNullOrEmpty()] [string]$Thumbprint,
        [Parameter(Mandatory=$false, ValueFromPipeline=$false)] [switch]$MachineStore)

  Process {
    #https://msdn.microsoft.com/en-us/library/windows/desktop/aa379399(v=vs.85).aspx
    #X509CertificateEnrollmentContext
    $ContextUser                     =0x1
    $ContextMachine                  =0x2
    $ContextAdministratorForceMachine=0x3

    #https://msdn.microsoft.com/en-us/library/windows/desktop/aa374936(v=vs.85).aspx
    #EncodingType
    $XCN_CRYPT_STRING_BASE64HEADER       =0
    $XCN_CRYPT_STRING_BASE64             =0x1
    $XCN_CRYPT_STRING_BINARY             =0x2
    $XCN_CRYPT_STRING_BASE64REQUESTHEADER=0x3
    $XCN_CRYPT_STRING_HEX                =0x4
    $XCN_CRYPT_STRING_HEXASCII           =0x5
    $XCN_CRYPT_STRING_BASE64_ANY         =0x6
    $XCN_CRYPT_STRING_ANY                =0x7
    $XCN_CRYPT_STRING_HEX_ANY            =0x8
    $XCN_CRYPT_STRING_BASE64X509CRLHEADER=0x9
    $XCN_CRYPT_STRING_HEXADDR            =0xa
    $XCN_CRYPT_STRING_HEXASCIIADDR       =0xb
    $XCN_CRYPT_STRING_HEXRAW             =0xc
    $XCN_CRYPT_STRING_NOCRLF             =0x40000000
    $XCN_CRYPT_STRING_NOCR               =0x80000000

    #https://msdn.microsoft.com/en-us/library/windows/desktop/aa379430(v=vs.85).aspx
    #X509RequestInheritOptions
    $InheritDefault               =0x00000000
    $InheritNewDefaultKey         =0x00000001
    $InheritNewSimilarKey         =0x00000002
    $InheritPrivateKey            =0x00000003
    $InheritPublicKey             =0x00000004
    $InheritKeyMask               =0x0000000f
    $InheritNone                  =0x00000010
    $InheritRenewalCertificateFlag=0x00000020
    $InheritTemplateFlag          =0x00000040
    $InheritSubjectFlag           =0x00000080
    $InheritExtensionsFlag        =0x00000100
    $InheritSubjectAltNameFlag    =0x00000200
    $InheritValidityPeriodFlag    =0x00000400
    $X509RequestInheritOptions=$InheritDefault+$InheritRenewalCertificateFlag+$InheritTemplateFlag

    if ($MachineStore.IsPresent) {
      $Path="Cert:\LocalMachine\My\$Thumbprint"
      $Context=$ContextAdministratorForceMachine
    }
    else {
      $Path="Cert:\CurrentUser\My\$Thumbprint"
      $Context=$ContextUser
    }
    $Cert=Get-Item -Path $Path

    $PKCS10=New-Object -ComObject X509Enrollment.CX509CertificateRequestPkcs10
    $PKCS10.Silent=$true
    $PKCS10.InitializeFromCertificate($Context,[System.Convert]::ToBase64String($Cert.RawData), $XCN_CRYPT_STRING_BASE64, $X509RequestInheritOptions)
    $PKCS10.AlternateSignatureAlgorithm=$false
    $PKCS10.SmimeCapabilities=$false
    $PKCS10.SuppressDefaults=$true
    $PKCS10.Encode()
    #OK=$InheritTemplateFlag+$InheritNewSimilarKey
    #OK=$InheritSubjectFlag+$InheritTemplateFlag+$InheritNewSimilarKey
    #OK=$InheritDefault+$InheritRenewalCertificateFlag+$InheritTemplateFlag

    #BAD=$InheritNewSimilarKey+$InheritRenewalCertificateFlag
    #BAD=$InheritDefault+$InheritRenewalCertificateFlag (Template required)

    #https://msdn.microsoft.com/en-us/library/windows/desktop/aa377809(v=vs.85).aspx
    $Enroll=New-Object -ComObject X509Enrollment.CX509Enrollment
    $Enroll.InitializeFromRequest($PKCS10)

    Write-Verbose "Renewing..."
    $Error.Clear()
    Try { $Enroll.Enroll() }
    Catch { 
      Write-Verbose "Unable to renew"
      $Errors=$Error.Clone()
      $Errors | ForEach-Object { Write-Error $_.Exception.Message }
      $result="0"
    }
    if ($Error.Count -eq 0) {
      $Cert=New-Object Security.Cryptography.X509Certificates.X509Certificate2
      $Cert.Import([System.Convert]::FromBase64String($Enroll.Certificate(1)))
      $result=$Cert.Thumbprint
      Write-Verbose "New Thumbprint is $result"
    }

    $result
  }
}