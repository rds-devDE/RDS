# Import Modules
Import-Module ActiveDirectory

# User Input for Group Name
$GroupSearch = Read-Host "Search groups"
$GroupLookup = Get-ADGroup -Filter "Name -like '*$GroupSearch*'"
$GroupLookup | Format-Table Name

# User Input for exact Group Name
$GroupExact = Read-Host "Add to this specific group"
$GroupAD = Get-ADGroup -Filter "Name -eq '$GroupExact'"

# User Input for exact User
$UserSearch = Read-Host "Search Users"
$UserLookup = Get-ADUser -Filter "Name -like '*$UserSearch*'"
$UserLookup | Format-Table Name

# User Input for exact User Name
$UserExact = Read-Host "Select all users (separate through commas)"
$UserArray = $UserExact -split ','

# Loop for each User in UserArray
Foreach ($User in $UserArray) {
    $User = $User.Trim()
    Add-ADGroupMember -Members $User -Identity $GroupAD
    Write-Host "$User added to $GroupExact"
}
