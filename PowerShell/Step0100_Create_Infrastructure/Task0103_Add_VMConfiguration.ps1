$Global:Summary = ""

#Functions
function First {
    Set-TimeZone -Name "W. Europe Standard Time"
    New-Item -Path "C:\Install" -ItemType Directory
    Set-NetFirewallProfile -Profile Domain, Public, Private -Enabled False
    #Log
    $Global:Summary += "`nTimeZone: W. Europe Standard Time"
    $Global:Summary += "`nNewPath:  C:\Install\"
    $Global:Summary += "`nFirewall: Disabled"
}

function Name {
    $ClientName = Read-Host "Client Name"
    Rename-Computer -NewName $ClientName
    $Global:Summary += "`nName:     $ClientName"
}

function IPv4 {
    (Get-NetAdapter | Where-Object {$_.Status -eq 'Up'}).Name
    $IPv4Adapter = Read-Host "`nType in one of the above"
    $IPv4Address = Read-Host "Address [IPv4]"
    $IPv4Netmask = Read-Host "Netmask [CIDR]"
    $IPv4Gateway = Read-Host "Gateway [IPv4]"
    New-NetIPAddress -InterfaceAlias $IPv4Adapter -IPAddress $IPv4Address -PrefixLength $IPv4Netmask -DefaultGateway $IPv4Gateway
    $Global:Summary += "`nAdapter:  $IPv4Adapter 
                        Address:  $IPv4Address/$IPv4Netmask 
                        Gateway:  $IPv4Gateway"
}

function DNS {
    (Get-NetAdapter | Where-Object {$_.Status -eq 'Up'}).Name
    $IPv4DNSAdapter = Read-Host "`nType in one of the above"
    $IPv4DNS = Read-Host "`nDNS [IPv4]"
    Set-DnsClientServerAddress -InterfaceAlias $IPv4DNSAdapter -ServerAddresses ($IPv4DNS)
    ipconfig /flushdns
    ipconfig /registerdns
    $Global:Summary += "`nDNS:      $IPv4DNS"
}

function Domain {
    $DomainName = Read-Host "Domain Name"
    Add-Computer -DomainName $DomainName
    $Global:Summary += "`nDomain:   $DomainName"
}

function Restart {
    Restart-Computer
    }

function Summary {
    Write-Host "Summary: `n$Global:Summary`n"
    Pause 
}

#While Loop for each function
while ($true) {
    CLS
    $input = Read-Host "
    --------------------------
    Select a function:        
    --------------------------
    First installtion: First 
    Change Name      : Name
    Change IPv4      : IPv4 
    Change DNS       : DNS
    Change Domain    : Domain

    Get Changes Made : Summary

    Restart Computer : Restart                       
    Exit             : Exit
    --------------------------
    "
    CLS
    # Abort with Exit
    if ($input -eq "Exit") {
        break
    }
    
    # Switch to select the function
    switch ($input) {
        "First" { First }
        "Name" { Name }
        "IPv4" { IPv4 }
        "DNS" { DNS }
        "Domain" { Domain }
        "Summary" { Summary }
        "Restart" { Restart }
        
        Default { Write-Host "Unknown Input: $input" }
    }
}
