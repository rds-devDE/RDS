# VM variables
$VmName = Read-Host "Name"
$Memory = [int](Read-Host "Memory (GB)")*1GB
$Storage = [int](Read-Host "Storage (GB)")*1GB
$CPU = [int](Read-Host "CPU-Cores")
$SwitchType = Read-Host "Switch-Type [e / i / p]"

# Create paths
$VMPath = "D:\VM\$VmName"
$VHDPath = "D:\VM\$VmName\Virtual Hard Disks\$VmName.vhdx"

# Create VM with defined variables
New-VM -Name $VmName -MemoryStartupBytes $Memory -BootDevice VHD -NewVHDPath $VHDPath -NewVHDSizeBytes $Storage -Path $VMPath -Generation 2
Set-VMProcessor -VMName $VmName -Count $CPU

# Select Switch
IF ($SwitchType -eq "e"){
    Connect-VMNetworkAdapter -VMName $VmName -SwitchName "V-Switch-External"
}ELSEIF ($SwitchType -eq "i"){
    Connect-VMNetworkAdapter -VMName $VmName -SwitchName "V-Switch-Internal"
}ELSEIF ($SwitchType -eq "p"){
    Connect-VMNetworkAdapter -VMName $VmName -SwitchName "V-Switch-Private"
}ELSE {
    Write-Host "Invalid Choice"
    BREAK
}
