﻿# VM Definieren
$VmName = Read-Host "Name"
$RAM = [int](Read-Host "RAM (GB)")*1GB
$Speicher = [int](Read-Host "Speicher (GB)")*1GB
$CPU = [int](Read-Host "CPU-Kerne")

# Pfade Erstellen
$VMPath = "D:\VM\$VmName"
$VHDPath = "D:\VM\$VmName\Virtual Hard Disks\$VmName.vhdx"

# VM Erstellen (Generation 2)
New-VM -Name $VmName -MemoryStartupBytes $RAM -BootDevice VHD -NewVHDPath $VHDPath -NewVHDSizeBytes $Speicher -Path $VMPath -Generation 2

# CPU-Kerne auf 2 setzen
Set-VMProcessor -VMName $VmName -Count $CPU

# Netzwerk-Switch setzen
Connect-VMNetworkAdapter -VMName $VmName -SwitchName "V-Switch-External"