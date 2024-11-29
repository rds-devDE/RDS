# Select Switch Type
$SwitchType = Read-Host "External [e]`nInternal [i] `nPrivate  [p] `n`nSelect a type"

IF ($SwitchType -eq "e"){
    CLS
    (Get-NetAdapter | Where-Object {$_.Status -eq 'Up'}).Name
    $aktiverNIC = Read-Host "`nType in one of the above"
    New-VMSwitch -Name "V-Switch-External" -NetAdapterName $aktiverNIC -AllowManagementOS $true
}ELSEIF ($SwitchType -eq "i"){
    CLS
    New-VMSwitch -Name "V-Switch-Internal" -SwitchType Internal
}ELSEIF ($SwitchType -eq "p"){
    CLS
    New-VMSwitch -Name "V-Switch-Private" -SwitchType Private 
}ELSE {
    CLS
    Write-Host "Keine korrekte Eingabe"
    BREAK
}   
