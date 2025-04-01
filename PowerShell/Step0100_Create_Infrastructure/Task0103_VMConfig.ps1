# Rename Computer
$ClientName = Read-Host "Client Name"
Rename-Computer -NewName $ClientName

# Select Domain
$DomainName = Read-Host "Domain Name"
Add-Computer -DomainName $DomainName

# Select TimeZone
Set-TimeZone -Name "W. Europe Standard Time"

# Create Standard Paths
New-Item -Path "C:\Install" -ItemType Directory

# Give a static IP with Gateway and DNS
(Get-NetAdapter | Where-Object {$_.Status -eq 'Up'}).Name
$IPv4Adapter = Read-Host "`nType in one of the above"
$IPv4Address = Read-Host "Address [IPv4]"
$IPv4Netmask = Read-Host "Netmask [CIDR]"
$IPv4Gateway = Read-Host "Gateway [IPv4]"
$IPv4DNS = Read-Host "`nDNS [IPv4]"
New-NetIPAddress -InterfaceAlias $IPv4Adapter -IPAddress $IPv4Address -PrefixLength $IPv4Netmask -DefaultGateway $IPv4Gateway
Set-DnsClientServerAddress -InterfaceAlias $IPv4DNSAdapter -ServerAddresses ($IPv4DNS)
ipconfig /flushdns
ipconfig /registerdns

# Restart
Restart-Computer
