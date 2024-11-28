Import-Module ActiveDirectory

# Anzahl Bots definieren
$Anzahl = [int](Read-Host "Anzahl Bots")
$PasswordLength = [int](Read-Host "Länge Passwort")
$Bot = [int](Read-Host "Nummer des ersten Bots")

# Zeichen definieren
$Buchstaben = 'abcdefghijklmnopqrstuvwxyz'
$GroBuchstaben = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
$Zahlen = '0123456789'
$Sonder = '!@#$%&()_+{}:<>?'
$Zeichen = $Buchstaben + $GroBuchstaben + $Zahlen + $Sonder

# Join jeweils ein Zeichen der verschiedenen Kategoriern und fülle den Rest auf (5 Zeichen) 
function Generate-Password {
     $password = -join (
        $Buchstaben[(Get-Random -Minimum 0 -Maximum $Buchstaben.Length)],
        $GroBuchstaben[(Get-Random -Minimum 0 -Maximum $GroBuchstaben.Length)],
        $Zahlen[(Get-Random -Minimum 0 -Maximum $Zahlen.Length)],
        $Sonder[(Get-Random -Minimum 0 -Maximum $Sonder.Length)]
    )
    
    $Auffuellen = $PasswordLength - $password.Length
    $password += -join (1..$Auffuellen | ForEach-Object { $Zeichen[(Get-Random -Minimum 0 -Maximum $Zeichen.Length)] })

    return $password
}

for ($i = 1; $i -le $Anzahl; $i++) {

    $password = Generate-Password

    $Name = "Bot" + "{0:D2}" -f $Bot

    $Bot = $Bot+1

    $SecurePassword = ConvertTo-SecureString $password -AsPlainText -Force

    New-ADUser -Name $Name `
               -AccountPassword $SecurePassword `
               -UserPrincipalName "$Name@domain.de" `
               -SamAccountName $Name `
               -Enabled $true `
               -PasswordNeverExpires $true `
               -ChangePasswordAtLogon $false `
               -Path "OU=Domain User,DC=domain,DC=de" 

    Write-Host "Created user $Name with password: $password"
}
