$FilePath = 'C:\Certificate\'
$StoreLocation = 'CurrentUser' # be aware that LocalMachine requires elevated privileges
$expirationYears = 1

$SubjectName = "GrphAPI"
$cert_password = "API"

$pfxFileName = $SubjectName + '.pfx'
$cerFileName = $SubjectName + '.cer'

$PfxFilePath = Join-Path -Path $FilePath -ChildPath $pfxFileName
$CerFilePath = Join-Path -Path $FilePath -ChildPath $cerFileName

$CertBeginDate = Get-Date
$CertExpiryDate = $CertBeginDate.AddYears($expirationYears)

$SecStringPw = ConvertTo-SecureString -String $cert_password -Force -AsPlainText

$Cert = New-SelfSignedCertificate -DnsName $SubjectName -CertStoreLocation "cert:\$StoreLocation\My" -NotBefore $CertBeginDate -NotAfter $CertExpiryDate -KeySpec Signature

Export-PfxCertificate -Cert $Cert -FilePath $PfxFilePath -Password $SecStringPw
Export-Certificate -Cert $Cert -FilePath $CerFilePath
