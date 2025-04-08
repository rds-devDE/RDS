# User Input for Computer
$ClientName = Read-Host "Client Name"
Rename-Computer -NewName $ClientName

# User Input for Domain
$DomainName = Read-Host "Domain Name"
Add-Computer -DomainName $DomainName

# Set TimeZone
Set-TimeZone -Name "W. Europe Standard Time"

# Set Standard Path
New-Item -Path "C:\Install" -ItemType Directory

# Set static IP with Gateway and DNS
(Get-NetAdapter | Where-Object {$_.Status -eq 'Up'}).Name
$IPv4Adapter = Read-Host "`nType in one of the above"
$IPv4Address = Read-Host "Address [IPv4]"
$IPv4Netmask = Read-Host "Netmask [CIDR]"
$IPv4Gateway = Read-Host "Gateway [IPv4]"
$IPv4DNS = Read-Host "DNS     [IPv4]"
New-NetIPAddress -InterfaceAlias $IPv4Adapter -IPAddress $IPv4Address -PrefixLength $IPv4Netmask -DefaultGateway $IPv4Gateway
Set-DnsClientServerAddress -InterfaceAlias $IPv4Adapter -ServerAddresses ($IPv4DNS)
ipconfig /flushdns
ipconfig /registerdns

# Restart
Restart-Computer
