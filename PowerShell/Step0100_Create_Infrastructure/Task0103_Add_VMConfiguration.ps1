#General
Set-TimeZone -Name "W. Europe Standard Time"
New-Item -Path "C:\Install" -ItemType Directory
$Summary = ""

#Config
CLS
$ClientChange = Read-Host "Change Name [y/n]"
if ($ClientChange -eq "y") {
    $ClientName = Read-Host "Client Name"
    Rename-Computer -NewName $ClientName
    $Summary += "`nName:    $ClientName"
} else {
    $Summary += "`nName:    Name skipped"
}

CLS
$DomainChange = Read-Host "Change Domain [y/n]"
if ($DomainChange -eq "y") {
    $DomainName = Read-Host "Domain Name"
    Add-Computer -DomainName $DomainName
    $Summary += "`nDomain:  $DomainName"
} else {
    $Summary += "`nDomain:  Domain skipped"
}

CLS
$IPv4Change = Read-Host "Change IPv4 [y/n]"
if ($IPv4Change -eq "y") {
    (Get-NetAdapter | Where-Object {$_.Status -eq 'Up'}).Name
    $IPv4Adapter = Read-Host "`nType in one of the above"
    $IPv4Address = Read-Host "Address [IPv4]"
    $IPv4Netmask = Read-Host "Netmask [CIDR]"
    $IPv4Gateway = Read-Host "Gateway [IPv4]"
    New-NetIPAddress -InterfaceAlias $IPv4Adapter -IPAddress $IPv4Address -PrefixLength $IPv4Netmask -DefaultGateway $IPv4Gateway
    $IPv4DNS = Read-Host "DNS [IPv4]"
    Set-DnsClientServerAddress -InterfaceAlias $IPv4Adapter -ServerAddresses ($IPv4DNS,"8.8.8.8")
    $Summary += "`nAdapter: $IPv4Adapter 
                 `nAddress: $IPv4Address/$IPv4Netmask 
                 `nGateway: $IPv4Gateway 
                 `nDNS:     $IPv4DNS"
} else {
    $Summary += "`nIPv4:    IPv4 skipped"
}

CLS
Write-Host "Summary: `n$Summary"

if ((Read-Host "Restart Now [y/n]") -eq "y"){
    Restart-Computer
} else {
    Exit
}
