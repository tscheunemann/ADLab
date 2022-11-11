function Create-NewDomainLocalGroup {
    $NameOfGroup = Read-Host "Enter the name of your new group"
    $DescriptionOfGroup = Read-Host "Enter the description of your new group"

    # Creates new domain local group
    New-ADGroup -Name $NameOfGroup -GroupScope DomainLocal -Description $DescriptionOfGroup
}

function Create-NewGlobalGroup {
    $NameOfGroup = Read-Host "Enter the name of your new group"
    $DescriptionOfGroup = Read-Host "Enter the description of your new group"

    # Creates new global group
    New-ADGroup -Name $NameOfGroup -GroupScope Global -Description $DescriptionOfGroup
}

function Create-NewUniversalGroup {
    $NameOfGroup = Read-Host "Enter the name of your new group"
    $DescriptionOfGroup = Read-Host "Enter the description of your new group"

    # Creates new universal group
    New-ADGroup -Name $NameOfGroup -GroupScope Universal -Description $DescriptionOfGroup
}

function Read-GroupAttributes {
    $NameOfGroup = Read-Host "Enter the group name"
    Get-ADGroup -Identity $NameOfGroup -Properties *
}

function Update-GroupName {
    $OldGroupName = Read-Host "Enter the old group name"
    $NewGroupName = Read-Host "Enter the new group name"

    # Changes group name
    Get-ADGroup -Identity $OldGroupName | Rename-ADObject -NewName $NewGroupName
    Set-ADGroup -Identity $OldGroupName -sAMAccountName $NewGroupName
}

function Delete-Group {
    $NameOfGroup = Read-Host "Enter the group that you would like to remove"

    # Confirm the user wants to remove the account
    while($True) {
        $VerifyRemove = Read-Host "Are you sure you want to remove" $NameOfGroup "? (y/N)"
        if ($VerifyRemove.ToLower() -eq "y") {
            Remove-ADGroup -Identity $NameOfGroup
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
    Write-Host "Group CRUD Menu"

    Write-Host "1. New domain local group"
    Write-Host "2. New global group"
    Write-Host "3. New universal group"
    Write-Host "4. Print group attributes"
    Write-Host "5. Change group name"
    Write-Host "6. Delete group"
    Write-Host "Q. Quit"
}

do {
    Build-Menu
    $UserInput = Read-Host "Select"
    switch ($UserInput) {
        "1" {
            Clear-Host
            Create-NewDomainLocalGroup
        }
        "2" {
            Clear-Host
            Create-NewGlobalGroup
        }
        "3" {
            Clear-Host
            Create-NewUniversalGroup
        }
        "4" {
            Clear-Host
            Read-GroupAttributes
        }
        "5" {
            Clear-Host
            Update-GroupName
        }
        "6" {
            Clear-Host
            Delete-Group
        }
        "q" {
            return
        }
    }
    pause
}

until ($UserInput -eq "q")