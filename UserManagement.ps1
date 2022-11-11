function Create-NewUser {
    $FirstName = Read-Host "Enter the user's first name"
    $LastName = Read-Host "Enter the user's last name"
    $Username = Read-Host "Enter a username for the new account"
    $UserPassword = Read-Host "Enter a password for the new account" -AsSecureString

    # Sets username if input is blank
    if ($Username.length -eq "") {
       $Username = $LastName + $FirstName.Substring(0,1)
    }

    # Adds an account with defined username, first name, last name, and account password
    New-ADUser -Name $Username -GivenName $FirstName -Surname $LastName -AccountPassword $UserPassword
}

function Add-UserToGroup {
    $UserParameter = Read-Host "Enter the user that you would like to add to a group"
    $GroupParameter = Read-Host "Enter the group name"

    # Adds user to the group specified
    Add-ADGroupMember -Identity $GroupParameter -Members $UserParameter
}

function Read-UserAttributes {
    $UserParameter = Read-Host "Enter the username"

    # Prints all user attributes
    Get-ADUser -Identity $UserParameter -Properties *
}

function Update-UserAccountName {
    $OldAccountName = Read-Host "Enter the name of the account you would like to change"
    $NewAccountName = Read-Host "Enter your new name"

    # Renames specified account
    Get-ADUser $OldAccountName | Rename-ADObject -NewName $NewAccountName
    Set-ADUser $OldAccountName -sAMAccountName $NewAccountName
}

function Update-UserPassword {
    $UserParameter = Read-Host "Enter the SamAccountName of the account you would like to edit"
    
    # Changes specified user's password
    Set-ADAccountPassword -Identity $UserParameter
}

function Delete-ADUserAccount {
    $UserParameter = Read-Host "Enter the user that you would like to remove"

    # Confirm the user wants to remove the account
    while($True) {
        $VerifyRemove = Read-Host "Are you sure you want to remove" $UserParameter "? (y/N)"
        if ($VerifyRemove.ToLower() -eq "y") {
            Remove-ADUser -Identity $UserParameter
            break
        }
        elseif ($VerifyRemove.length -eq "" -Or $VerifyRemove.ToLower() -eq "n") {
            Write-Host "Cancelled"
            break
        }
        else {
            Write-Host "Invalid input, please try again"
            continue
        }
    }
}

function Build-Menu {
    Write-Host "User CRUD Menu"

    Write-Host "1. Create new user"
    Write-Host "2. Add user to a group"
    Write-Host "3. Print user attributes"
    Write-Host "4. Change account name"
    Write-Host "5. Change account password"
    Write-Host "6. Delete user"
    Write-Host "Q. Quit"
}

do {
    Build-Menu
    $UserInput = Read-Host "Select"
    switch ($UserInput) {
        "1" {
            Clear-Host
            Create-NewUser
        }
        "2" {
            Clear-Host
            Add-UserToGroup
        }
        "3" {
            Clear-Host
            Read-UserAttributes
        }
        "4" {
            Clear-Host
            Update-UserAccountName
        }
        "5" {
            Clear-Host
            Update-UserPassword
        }
        "6" {
            Clear-Host
            Delete-ADUserAccount
        }
        "q" {
            return
        }
    }
    pause
}

until ($UserInput -eq "q")