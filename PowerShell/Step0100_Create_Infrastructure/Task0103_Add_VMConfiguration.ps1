#General
Set-TimeZone -Name "W. Europe Standard Time"
New-Item -Path "C:\Install" -ItemType Directory
$Summary = ""

#Change Device Name
CLS
$ClientChange = Read-Host "Change Name [y/n]"
if ($ClientChange -eq "y") {
    $ClientName = Read-Host "Client Name"
    Rename-Computer -NewName $ClientName
    CLS
    $Summary += "`nName:    $ClientName"
} else {
    CLS
    $Summary += "`nName:    Name skipped"
}

#Change IPv4 Address
CLS
$IPv4Change = Read-Host "Change IPv4 [y/n]"
if ($IPv4Change -eq "y") {
    (Get-NetAdapter | Where-Object {$_.Status -eq 'Up'}).Name
    $IPv4Adapter = Read-Host "`nType in one of the above"
    $IPv4Address = Read-Host "Address [IPv4]"
    $IPv4Netmask = Read-Host "Netmask [CIDR]"
    $IPv4Gateway = Read-Host "Gateway [IPv4]"
    New-NetIPAddress -InterfaceAlias $IPv4Adapter -IPAddress $IPv4Address -PrefixLength $IPv4Netmask -DefaultGateway $IPv4Gateway
    $Summary += "`nAdapter: $IPv4Adapter 
                 `nAddress: $IPv4Address/$IPv4Netmask 
                 `nGateway: $IPv4Gateway"
} else {
    CLS
    $Summary += "`nIPv4:    IPv4 skipped"
}

#Change IPv4 DNS Server
cLS
$IPv4DNSChange = Read-Host "Change DNS [y/n]"
if ($IPv4DNSChange -eq "y") {
    (Get-NetAdapter | Where-Object {$_.Status -eq 'Up'}).Name
    $IPv4DNSAdapter = Read-Host "`nType in one of the above"
    $IPv4DNS = Read-Host "DNS [IPv4]"
    Set-DnsClientServerAddress -InterfaceAlias $IPv4DNSAdapter -ServerAddresses ($IPv4DNS)
    ipconfig /flushdns
    ipconfig /registerdns
    $Summary += "`nDNS:     $IPv4DNS"
} else {
    CLS
    $Summary += "`nDNS:     DNS skipped"
}

#Change Domain
CLS
$DomainChange = Read-Host "Change Domain [y/n]"
if ($DomainChange -eq "y") {
    $DomainName = Read-Host "Domain Name"
    Add-Computer -DomainName $DomainName
    CLS
    $Summary += "`nDomain:  $DomainName"
} else {
    CLS
    $Summary += "`nDomain:  Domain skipped"
}

CLS
Write-Host "Summary: `n$Summary"


if ((Read-Host "Restart Now [y/n]") -eq "y"){
    Restart-Computer
} else {
    Break
}
