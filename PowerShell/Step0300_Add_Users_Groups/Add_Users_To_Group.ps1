#Gruppenauswahl
$GroupSearch = Read-Host "Search groups"

$GroupLookup = Get-ADGroup -Filter "Name -like '*$GroupSearch*'"
$GroupLookup | Format-Table Name

$GroupExact = Read-Host "Add to this specific group"
$GroupAD = Get-ADGroup -Filter "Name -eq '$GroupExact'"

#Userauswahl
$UserSearch = Read-Host "Search Users"

$UserLookup = Get-ADUser -Filter "Name -like '*$UserSearch*'"
$UserLookup | Format-Table Name

$UserExact = Read-Host "Select all users (separate through commas)"

$UserArray = $UserExact -split ','

Foreach ($User in $UserArray) {
    $User = $User.Trim()
    Add-ADGroupMember -Members $User -Identity $GroupAD
    Write-Host "$User added to $GroupExact"
}
