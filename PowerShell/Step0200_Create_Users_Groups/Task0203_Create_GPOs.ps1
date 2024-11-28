# GPOs definieren
$GpoAutomaticUpdates = "Automatische Windows Updates"
$GpoSSOforRDS = "SSO fuer RDS"

# GPOs erstellen
New-GPO -Name $GpoName
New-GPO -Name $GpoSSOforRDS

# GpoAutomaticUpdates - RegKeys
# Registry Pfad
$RegistryPath = "HKLM\Software\Policies\Microsoft\Windows\WindowsUpdate\AU"
# Automatische Updates aktivieren und tägliche Installation festlegen
Set-GPRegistryValue -Name $GpoAutomaticUpdates -Key $RegistryPath -ValueName "NoAutoUpdate" -Type DWord -Value 0 
Set-GPRegistryValue -Name $GpoAutomaticUpdates -Key $RegistryPath -ValueName "AUOptions" -Type DWord -Value 4  # Automatische Updates herunterladen und installieren
# Installationszeit auf 00:00 Uhr täglich setzen
Set-GPRegistryValue -Name $GpoAutomaticUpdates -Key $RegistryPath -ValueName "ScheduledInstallDay" -Type DWord -Value 0 # Jeden Tag
Set-GPRegistryValue -Name $GpoAutomaticUpdates -Key $RegistryPath -ValueName "ScheduledInstallTime" -Type DWord -Value 0 # Uhrzeit: 00:00 Uhr

# GpoSSOforRDS - RegKeys
# Registry Pfade
$RegKey = "HKLM\SOFTWARE\Policies\Microsoft\Windows\CredentialsDelegation"
$ExtRegKey = "$RegKey\AllowDefaultCredentials"
# Registry Werte
$RegName = "1"
$RegData = "termsrv/connectionbrokerFQDN.domain.de"
# AllowDefaultCredentials aktivieren (DWORD = 1)
Set-GPRegistryValue -Name $GpoSSOforRDS -Key $RegKey -ValueName "AllowDefaultCredentials" -Type DWORD -Value 1
# Neuen Key unter AllowDefaultCredentials erstellen und Servernamen setzen
Set-GPRegistryValue -Name $GpoSSOforRDS -Key $ExtRegKey -ValueName $RegName -Type String -Value $RegData
