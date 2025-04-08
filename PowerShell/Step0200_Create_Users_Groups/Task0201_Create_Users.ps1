# Import Modules
Import-Module ActiveDirectory

# User Input for Bot Creation 
$Anzahl = [int](Read-Host "Anzahl Bots")
$PasswordLength = [int](Read-Host "Länge Passwort")
$Bot = [int](Read-Host "Nummer des ersten Bots")
$domain = Read-Host "Domain"

# Character Sets for Password Generation
$Buchstaben = 'abcdefghijklmnopqrstuvwxyz'
$GroBuchstaben = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
$Zahlen = '0123456789'
$Sonder = '!@#$%&()_+{}:<>?'
$Zeichen = $Buchstaben + $GroBuchstaben + $Zahlen + $Sonder

# Password Generation Function
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


# Loop to Create Bots
for ($i = 1; $i -le $Anzahl; $i++) {
    $password = Generate-Password
    $Name = "Bot" + "{0:D2}" -f $Bot
    $Bot = $Bot+1
    $SecurePassword = ConvertTo-SecureString $password -AsPlainText -Force

    New-ADUser -Name $Name `
               -AccountPassword $SecurePassword `
               -UserPrincipalName "$Name@$domain" `
               -SamAccountName $Name `
               -Enabled $true `
               -PasswordNeverExpires $true `
               -ChangePasswordAtLogon $false `
               -Path "OU=Domain User,DC=domain,DC=de" 

    Write-Host "Created user $Name with password: $password"
}
