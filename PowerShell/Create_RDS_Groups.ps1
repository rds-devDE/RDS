Import-Module ActiveDirectory
cls

$Names = Read-Host "Geben Sie die Namen der Anwenungen ein (getrennt durch Kommas) `n --> "
Write-Host ""

$NameArray = $Names -split ','

Foreach ($Name in $NameArray){
    $Name = $Name.Trim() #Entfernen von versehentlichen Leerzeichen
    New-ADGroup -Name "B_RDS_$Name" -Path "OU=RDS,OU=Domain Groups,DC=rds-lab,DC=de" -GroupScope Global -GroupCategory Security -Description "Berechtigung für RDS-Anwendung $Name"
    Write-Host "Sicherheitsgruppe erstellt: B_RDS_$Name"
}
