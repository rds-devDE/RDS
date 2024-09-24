$SwitchType = Read-Host "Typ [e / i / p]"

IF ($SwitchType -eq "e"){
    New-VMSwitch -Name "V-Switch-External" -SwitchType External
}ELSEIF ($SwitchType -eq "i"){
    New-VMSwitch -Name "V-Switch-Internal" -SwitchType Internal
}ELSEIF ($SwitchType -eq "p"){
    New-VMSwitch -Name "V-Switch-Private" -SwitchType Private
}ELSE {
    Write-Host "Keine korrekte Eingabe"
    BREAK
}   
