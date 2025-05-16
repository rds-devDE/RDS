# Import Modules
Import-Module ActiveDirectory
Clear-Host

# User Input for Application Names
$Names = Read-Host "Geben Sie die Namen der Anwenungen ein (getrennt durch Kommas) `n --> "
$NameArray = $Names -split ','

# Loop for each Application Name to create a AD-Group
Foreach ($Name in $NameArray){
    $Name = $Name.Trim() #Entfernen von versehentlichen Leerzeichen
    New-ADGroup -Name "RDS_$Name" -Path "OU=RDS,OU=Domain Groups,DC=,DC=de" -GroupScope Global -GroupCategory Security -Description "Berechtigung für RDS-Anwendung $Name"
    Write-Host "Sicherheitsgruppe erstellt: B_RDS_$Name"
}
