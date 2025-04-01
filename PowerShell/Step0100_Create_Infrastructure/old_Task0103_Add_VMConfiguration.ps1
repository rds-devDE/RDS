#Global Variables
$Global:ValueTimeZone = (Get-TimeZone).Id
$Global:ValueFireWall = (Get-NetFirewallProfile -Profile Domain, Public, Private | Select-Object Name, Enabled | ForEach-Object { "$($_.Name): $($_.Enabled)" }) -join ' | '
$Global:ValuePaths = Test-Path -Path "C:\Install\"
$Global:ValueName = $env:COMPUTERNAME
$Global:ValueIPv4 = (Get-NetIPAddress -InterfaceAlias "Ethernet" | Where-Object { $_.AddressFamily -eq "IPv4" }).IPAddress
$Global:ValueGateway = (Get-NetIPConfiguration -InterfaceAlias "Ethernet" | Where-Object { $_.IPv4DefaultGateway }).IPv4DefaultGateway.NextHop
$Global:ValueDNS = Get-DnsClientServerAddress -AddressFamily IPv4 | Select-Object -ExpandProperty ServerAddresses
$Global:ValueDomain = (Get-WmiObject Win32_ComputerSystem).Domain

#Functions
function TimeZone {
    Set-TimeZone -Name "W. Europe Standard Time"
}

function FireWall {
    $FirewallOnOff = Read-Host "FireWall [On/Off]"
    if ($FirewallOnOff -eq "On"){
        Set-NetFirewallProfile -Profile Domain, Public, Private -Enabled True
    }elseif ($FirewallOnOff -eq "Off"){
        Set-NetFirewallProfile -Profile Domain, Public, Private -Enabled False
    }
}

function Paths {
    New-Item -Path "C:\Install" -ItemType Directory
}

function Name {
    $ClientName = Read-Host "Client Name"
    Rename-Computer -NewName $ClientName
}

function IPv4 {
    (Get-NetAdapter | Where-Object {$_.Status -eq 'Up'}).Name
    $IPv4Adapter = Read-Host "`nType in one of the above"
    $IPv4Address = Read-Host "Address [IPv4]"
    $IPv4Netmask = Read-Host "Netmask [CIDR]"
    New-NetIPAddress -InterfaceAlias $IPv4Adapter -IPAddress $IPv4Address -PrefixLength $IPv4Netmask
}

function Gateway {
    (Get-NetAdapter | Where-Object {$_.Status -eq 'Up'}).Name
    $IPv4Adapter = Read-Host "`nType in one of the above"
    $IPv4Gateway = Read-Host "Gateway [IPv4]"
    New-NetIPAddress -InterfaceAlias $IPv4Adapter -DefaultGateway $IPv4Gateway
}

function DNS {
    (Get-NetAdapter | Where-Object {$_.Status -eq 'Up'}).Name
    $IPv4DNSAdapter = Read-Host "`nType in one of the above"
    $IPv4DNS = Read-Host "`nDNS [IPv4]"
    Set-DnsClientServerAddress -InterfaceAlias $IPv4DNSAdapter -ServerAddresses ($IPv4DNS)
    ipconfig /flushdns
    ipconfig /registerdns
}

function Domain {
    $DomainName = Read-Host "Domain Name"
    Add-Computer -DomainName $DomainName
}

function Restart {
    Restart-Computer
    }

#While Loop for each function
while ($true) {
    CLS
    $input = Read-Host "
    ------------------------------------------------------------------------------------------------
    Select a function:          | Active Value    
    ------------------------------------------------------------------------------------------------
    Set TimeZone     : TimeZone | $Global:ValueTimeZone
    Change FireWall  : FireWall | $Global:ValueFireWall
    Set Paths        : Path     | $Global:ValuePaths
    Change Name      : Name     | $Global:ValueName
    Change IPv4      : IPv4     | $Global:ValueIPv4
    Change Gateway   : Gateway  | $Global:ValueGateway
    Change DNS       : DNS      | $Global:ValueDNS
    Change Domain    : Domain   | $Global:ValueDomain
                                |
    Restart Computer : Restart  |                 
    Exit             : Exit     |
    ------------------------------------------------------------------------------------------------
    "
    CLS
    # Abort with Exit
    if ($input -eq "Exit") {
        break
    }
    
    # Switch to select the function
    switch ($input) {
        "TimeZone" { TimeZone }
        "FireWall" { FireWall }
        "Paths" { Paths }
        "Name" { Name }
        "IPv4" { IPv4 }
        "Gateway" { Gateway }
        "DNS" { DNS }
        "Domain" { Domain }
        "Restart" { Restart }
        
        Default { Write-Host "Unknown Input: $input" }
    }
}
