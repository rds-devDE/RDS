# Erstellen der GPO
$GpoAutomaticUpdates = "Automatische Windows Updates"
New-GPO -Name $GpoName

# Registry Pfad
$RegistryPath = "HKLM\Software\Policies\Microsoft\Windows\WindowsUpdate\AU"

# Automatische Updates aktivieren und tägliche Installation festlegen
Set-GPRegistryValue -Name $GpoAutomaticUpdates -Key $RegistryPath -ValueName "NoAutoUpdate" -Type DWord -Value 0 
Set-GPRegistryValue -Name $GpoAutomaticUpdates -Key $RegistryPath -ValueName "AUOptions" -Type DWord -Value 4  # Automatische Updates herunterladen und installieren

# Installationszeit auf 00:00 Uhr täglich setzen
Set-GPRegistryValue -Name $GpoAutomaticUpdates -Key $RegistryPath -ValueName "ScheduledInstallDay" -Type DWord -Value 0 # Jeden Tag
Set-GPRegistryValue -Name $GpoAutomaticUpdates -Key $RegistryPath -ValueName "ScheduledInstallTime" -Type DWord -Value 0 # Uhrzeit: 00:00 Uhr
