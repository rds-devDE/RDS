# Select Switch Type
$SwitchType = Read-Host "External [e]`nInternal [i] `nPrivate  [p] `n`nSelect a type"

# Create Switch depending on input
IF ($SwitchType -eq "e"){
    Clear-Host
    (Get-NetAdapter | Where-Object {$_.Status -eq 'Up'}).Name
    $aktiverNIC = Read-Host "`nType in one of the above"
    New-VMSwitch -Name "V-Switch-External" -NetAdapterName $aktiverNIC -AllowManagementOS $true
}ELSEIF ($SwitchType -eq "i"){
    Clear-Host
    New-VMSwitch -Name "V-Switch-Internal" -SwitchType Internal
}ELSEIF ($SwitchType -eq "p"){
    Clear-Host
    New-VMSwitch -Name "V-Switch-Private" -SwitchType Private 
}ELSE {
    Clear-Host
    Write-Host "Invalid Choice"
    BREAK
}   
