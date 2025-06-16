<#PSScriptInfo
.SYNOPSIS
    Script to Map Objects for AAD joined computers

.DESCRIPTION
    This script will create user accounts from csv file
    If attributes are not defined then it will use set of pre-defined values
        
.NOTES
    Written by Omar Assaf

.VERSION
    1.1

.AUTHOR
    Omar Assaf
    @omar_assaf

.COMPANYNAME 
    CybeRack

.COPYRIGHT
    Feel free to use this, But would be grateful if My name is mentioned in Notes 
#>

# Default attribute values
$defaultAttributes = @{
    Description          = "Default Description"
    Title                = "Employee"
    Department           = "IT"
    Company              = "Contoso Ltd"
    memberOf             = "CN=DefaultGroup,OU=Groups,DC=contoso,DC=com"
    extensionAttribute5  = "DefaultExt5"
    extensionAttribute6  = "DefaultExt6"
    extensionAttribute7  = "DefaultExt7"
    extensionAttribute8  = "DefaultExt8"
}

# Import CSV file
$csvPath = "C:\Path\To\Users.csv"
$users = Import-Csv -Path $csvPath

foreach ($user in $users) {
    # Create a hashtable for user attributes
    $userAttributes = @{}

    foreach ($key in $defaultAttributes.Keys) {
        $userAttributes[$key] = if ($user.$key) { $user.$key } else { $defaultAttributes[$key] }
    }

    # Construct user creation parameters
    $userParams = @{
        Name               = $user.Name
        SamAccountName     = $user.SamAccountName
        UserPrincipalName  = $user.UserPrincipalName
        GivenName          = $user.GivenName
        Surname            = $user.Surname
        DisplayName        = $user.DisplayName
        Description        = $userAttributes["Description"]
        Title              = $userAttributes["Title"]
        Department         = $userAttributes["Department"]
        Company            = $userAttributes["Company"]
        Path               = $user.OU
        AccountPassword    = (ConvertTo-SecureString $user.Password -AsPlainText -Force)
        Enabled            = $true
    }

    # Create the user
    New-ADUser @userParams
    # Set extension attributes
    Set-ADUser -Identity $user.SamAccountName -Replace @{
        extensionAttribute5 = $userAttributes["extensionAttribute5"]
        extensionAttribute6 = $userAttributes["extensionAttribute6"]
        extensionAttribute7 = $userAttributes["extensionAttribute7"]
        extensionAttribute8 = $userAttributes["extensionAttribute8"]
    }

    # Add user to group
    Add-ADGroupMember -Identity $userAttributes["memberOf"] -Members $user.SamAccountName
}
