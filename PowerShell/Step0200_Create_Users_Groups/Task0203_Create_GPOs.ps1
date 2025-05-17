# Set GPO Names
$GpoAutoUp = "Automatische Windows Updates"
$GpoSSORDS = "SSO fuer RDS"

# Create GPOs
New-GPO -Name $GpoAutoUp
New-GPO -Name $GpoSSORDS

# GpoAutoUp
$RegPathAutoUp = "HKLM\Software\Policies\Microsoft\Windows\WindowsUpdate\AU"
Set-GPRegistryValue -Name $GpoAutoUp -Key $RegPathAutoUp -ValueName "NoAutoUpdate" -Type DWord -Value 0 # Automatic Update active
Set-GPRegistryValue -Name $GpoAutoUp -Key $RegPathAutoUp -ValueName "AUOptions" -Type DWord -Value 4  # Download and Install
Set-GPRegistryValue -Name $GpoAutoUp -Key $RegPathAutoUp -ValueName "ScheduledInstallDay" -Type DWord -Value 0 # Every Day
Set-GPRegistryValue -Name $GpoAutoUp -Key $RegPathAutoUp -ValueName "ScheduledInstallTime" -Type DWord -Value 0 # Time: 00:00

# GpoSSORDS
$RegPathSSORDS = "HKLM\SOFTWARE\Policies\Microsoft\Windows\CredentialsDelegation"
$RegPathSSORDSExt = "$RegPathSSORDS\AllowDefaultCredentials"
$RegName = "1"
$RegData = "termsrv/connectionbrokerFQDN.domain.de" # FQDN for CB-Server 
Set-GPRegistryValue -Name $GpoSSORDS -Key $RegPathSSORDS -ValueName "AllowDefaultCredentials" -Type DWORD -Value 1 # Allow Default Credentials
Set-GPRegistryValue -Name $GpoSSORDS -Key $RegPathSSORDSExt -ValueName $RegName -Type String -Value $RegData # New Key for CB-Server
