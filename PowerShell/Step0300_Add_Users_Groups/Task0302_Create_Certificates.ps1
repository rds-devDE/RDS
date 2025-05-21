# Parameter
$certName = "fqdn.domain.de"
$certPath = "C:\temp"
$certFile = "$certPath\$certName.cer"
$pfxFile  = "$certPath\$certName.pfx"

# Create New Folder
New-Item -Path $certPath -ItemType Directory -Force

# Self-signed 
$cert = New-SelfSignedCertificate `
    -DnsName $certName `
    -CertStoreLocation "Cert:\LocalMachine\My" `
    -KeyExportPolicy Exportable `
    -KeyLength 2048 `
    -KeyAlgorithm RSA `
    -HashAlgorithm SHA256 `
    -NotAfter (Get-Date).AddYears(5) `
    -FriendlyName "RDS Connection Broker Self-Signed"

# Export Certificate as .CER
Export-Certificate `
    -Cert $cert `
    -FilePath $certFile

# Export Certificate as .PFX
Export-PfxCertificate `
    -Cert $cert `
    -FilePath $pfxFile `
    -Password (ConvertTo-SecureString -String "Server123" -Force -AsPlainText)
