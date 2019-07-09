<#
#Remote Session

#On server:
Enable-PSRemoting

#On client
Set-Item WSMan:\localhost\Client\TrustedHosts 192.168.56.2
Enter-PSSession 192.168.56.2
#>

function Menu{
    Clear-Host
    Write-Host "Press 1 to create user"
    Write-Host "Press 2 to delete user"
    Write-Host "Press 3 to create group"
    Write-Host "Press 4 to delete group"
    Write-Host "Press 5 to add user in a group"
    Write-Host "Press 6 to delete user in a group"
    Write-Host "Press q to exit this script"
    Write-Host ""

    $choice = Read-Host "What do  you do ?"


    switch ($choice){
       '1' {addUser}
       '2' {delUser}
       '3' {addGroup}
       '4' {delGroup}
       '5' {addMember}
       '6' {delMember}
       'q' {exit}       
    }
}

function subMenu{
    Clear-Host
    if ($task -match "addUser"){
        $sentence1="create Local user"
        $sentence2="create AD user"
    }
    elseif ($task -match "delUser"){
        $sentence1="delete Local user"
        $sentence2="delete AD user"
    }
    elseif ($task -match "addGroup"){
        $sentence1="add Local group"
        $sentence2="add AD group"
    }
    elseif ($task -match "delGroup"){
         $sentence1="delete Local group"
         $sentence2="delete AD group"
    }
    elseif ($task -match "addMember"){
         $sentence1="add Local group's member"
         $sentence2="add AD group's member"
    }
    elseif ($task -match "delMember"){
         $sentence1="delete Local group's member"
         $sentence2="delete AD group's member"
    }

    Write-Host "Press 1 to $sentence1 from command line"
    Write-Host "Press 2 to $sentence1 from files"
    Write-Host "Press 3 to $sentence2 from command line"
    Write-Host "Press 4 to $sentence2 from files"
    Write-Host "Press q to return on menu"
    Write-Host ""
    
    $choice = Read-Host "What do  you do ?"


    switch ($choice){
       '1' {invoke-expression $task"LC"}
       '2' {invoke-expression $task"LF"}
       '3' {invoke-expression $task"AC"}
       '4' {invoke-expression $task"AF"}
       'q' {Menu}    
    }
}

function addUser{  
    $global:task=$MyInvocation.MyCommand
    subMenu
}

function addUserLC{
    Clear-Host
    $name=Read-Host -Prompt "What's name of your user"
    New-LocalUser -Name $name
    Get-LocalUser | Select-Object name
}

function addUserLF{
    Clear-Host
    $ufile=Read-Host -Prompt "Give me the path of your user's file"
    $line=Get-Content $ufile
    foreach ($name in $line){
        New-LocalUser -Name $name
    }
    Get-LocalUser | Select-Object name
}

function addUserAC{
    Clear-Host
    $name=Read-Host -Prompt "What's name of your user"
    $surname=Read-Host -Prompt "What's surname of your user"
    $display=$name+" "+$surname
    $login=($name+"."+$surname).ToLower()
    New-ADUser -Name $display -GivenName $name -Surname $surname -DisplayName $display -SamAccountName $login -AccountPassword(Read-Host -AsSecureString "Password for $display :") -ChangePasswordAtLogon 1 -Enabled 1
    Get-ADUser -F * | Select-Object name
}


function addUserAF{
    Clear-Host
    $ufile=Read-Host -Prompt "Give me the path of your user's file"
    $line=Get-Content $ufile
    foreach ($column in $line){
        $name=$column.split(" ")[0]
        $surname=$column.split(" ")[1]
        $display=$name+" "+$surname
        $login=($name+"."+$surname).ToLower()
        New-ADUser -Name $display -GivenName $name -Surname $surname -DisplayName $display -SamAccountName $login -AccountPassword(Read-Host -AsSecureString "Password for $display :") -ChangePasswordAtLogon 1 -Enabled 1
    }
    Get-ADUser -F * | Select-Object name  
}


function delUser{
    $global:task=$MyInvocation.MyCommand
    subMenu
}

function delUserLC{
    Clear-Host
    $name=Read-Host -Prompt "What's name of your user"
    Remove-LocalUser -Name $name
    Get-LocalUser | Select-Object name
}

function delUserLF{
    Clear-Host
    $ufile=Read-Host -Prompt "Give me the path of your user's file"
    $line=Get-Content $ufile
    foreach ($name in $line){
        Remove-LocalUser -Name $name
    }
    Get-LocalUser | Select-Object name
}

function delUserAC{
    Clear-Host
    $name=Read-Host -Prompt "What's name of your user"
    $surname=Read-Host -Prompt "What's surname of your user"
    $login=($name+"."+$surname).ToLower()
    Remove-ADUser -Identity $login
    Get-ADUser -F * | Select-Object name
}


function delUserAF{
    Clear-Host
    $ufile=Read-Host -Prompt "Give me the path of your user's file"
    $line=Get-Content $ufile
    foreach ($column in $line){
        $name=$column.split(" ")[0]
        $surname=$column.split(" ")[1]
        $login=($name+"."+$surname).ToLower()
        Remove-ADUser -Identity $login
    }
    Get-ADUser -F * | Select-Object name  
}


function addGroup{
    $global:task=$MyInvocation.MyCommand
    subMenu
}

function addGroupLC{
    Clear-Host
    $name=Read-Host -Prompt "What's name of your group"
    New-LocalGroup -Name $name
    Get-LocalGroup | Select-Object name
}

function addGroupLF{
      Clear-Host
      $ufile=Read-Host -Prompt "Give me the path of your group's file"
      $line=Get-Content $ufile
      foreach ($name in $line){
        New-LocalGroup -Name $name
      }
      Get-LocalGroup | Select-Object name
}

function addGroupAC{
    Clear-Host
    $name=Read-Host -Prompt "What's name of your group"
    New-ADGroup -GroupScope 0 -Name $name
    Get-ADGroup -F * | Select-Object name
}


function addGroupAF{
    Clear-Host
    $ufile=Read-Host -Prompt "Give me the path of your group's file"
    $line=Get-Content $ufile
    foreach ($name in $line){
        New-ADGroup -GroupScope 0 -Name $name
    }
    Get-ADGroup -F * | Select-Object name  
}


function delGroup{
    $global:task=$MyInvocation.MyCommand
    subMenu
}

function delGroupLC{
    Clear-Host
    $name=Read-Host -Prompt "What's name of your group"
    Remove-LocalGroup -Name $name
    Get-LocalGroup | Select-Object name
}

function delGroupLF{
    Clear-Host
    $ufile=Read-Host -Prompt "Give me the path of your group's file"
    $line=Get-Content $ufile
    foreach ($name in $line){
        Remove-LocalGroup -Name $name
    }
    Get-LocalGroup | Select-Object name
}

function delGroupAC{
    Clear-Host
    $name=Read-Host -Prompt "What's name of your group"
    Remove-ADGroup -Identity $name
    Get-ADGroup -F * | Select-Object name
}


function delGroupAF{
    Clear-Host
    $ufile=Read-Host -Prompt "Give me the path of your group's file"
    $line=Get-Content $ufile
    foreach ($name in $line){
        Remove-ADGroup -Identity $name
    }
    Get-ADGroup -F * | Select-Object name  
}


function addMember{
    $global:task=$MyInvocation.MyCommand
    subMenu
}

function addMemberLC{
    Clear-Host
    $name=Read-Host -Prompt "What's name of your user"
    $gName=Read-Host -Prompt "What's name of your group"
    Add-LocalGroupMember -Name $gName -Member $name
    Write-Host "Membre du groupe $gName :"
    Get-LocalGroupMember $gName | Select-Object -expand name
}


function addMemberLF{
    Clear-Host
    $ufile=Read-Host -Prompt "Give me the path of your member's file"
    $line=Get-Content $ufile
    foreach ($column in $line){
        $name=$column.split(" ")[0]
        $gName=$column.split(" ")[1]
        Add-LocalGroupMember -Name $gName -Member $name
    }
    Write-Host "Membre du groupe $gName :"
    Get-LocalGroupMember $gName | Select-Object -expand name
}


function addMemberAC{
    Clear-Host
    $name=Read-Host -Prompt "What's name of your user"
    $gName=Read-Host -Prompt "What's name of your group"
    Add-ADGroupMember -Identity $gName -Members $name
    Write-Host "Membre du groupe $gName :"
    Get-ADGroupMember $gName | Select-Object -expand name
}


function addMemberAF{
    Clear-Host
    $ufile=Read-Host -Prompt "Give me the path of your member's file"
    $line=Get-Content $ufile
    foreach ($column in $line){
        $name=$column.split(" ")[0]
        $surname=$column.split(" ")[1]
        $login=($name+"."+$surname).ToLower()
        $gName=$column.split(" ")[2]
        Add-ADGroupMember -Identity $gName -Members $login
    }
    Write-Host "Membre du groupe $gName :"
    Get-ADGroupMember $gName | Select-Object -expand name    
}


function delMember{
    $global:task=$MyInvocation.MyCommand
    subMenu
}

function delMemberLC{
    Clear-Host
    $name=Read-Host -Prompt "What's name of your user"
    $gName=Read-Host -Prompt "What's name of your group"
    Remove-LocalGroupMember -Name $gName -Member $name
    Write-Host "Membre du groupe $gName :"
    Get-LocalGroupMember $gName | Select-Object -expand name
}


function delMemberLF{
    Clear-Host
    $ufile=Read-Host -Prompt "Give me the path of your member's file"
    $line=Get-Content $ufile
    foreach ($column in $line){
        $name=$column.split(" ")[0]
        $gName=$column.split(" ")[1]
        Remove-LocalGroupMember -Name $gName -Member $name
    }
    Get-LocalGroupMember $gName | Select-Object name
}


function delMemberAC{
    Clear-Host
    $name=Read-Host -Prompt "What's name of your user"
    $gName=Read-Host -Prompt "What's name of your group"
    Remove-ADGroupMember -Identity $gName -Members $name
    Write-Host "Membre du groupe $gName :"
    Get-ADGroupMember $gName | Select-Object -expand name
}


function delMemberAF{
    Clear-Host
    $ufile=Read-Host -Prompt "Give me the path of your member's file"
    $line=Get-Content $ufile
     foreach ($column in $line){
        $name=$column.split(" ")[0]
        $surname=$column.split(" ")[1]
        $login=($name+"."+$surname).ToLower()
        $gName=$column.split(" ")[2]
        Remove-ADGroupMember -Identity $gName -Members $login
    }
    Write-Host "Membre du groupe $gName :"
    Get-ADGroupMember $gName | Select-Object -expand name    
}


Menu