param([Parameter(Mandatory=$true)] $JsonFile)

function CreateAdGroup(){
    param([Parameter(Mandatory=$true)] $groupObject)
    New-AdGroup -name $groupObject.Name  -GroupScope Global
}


function CreateAdUser(){
    param([Parameter(Mandatory=$true)] $userObject)
   ##pull out name from json object
    $name = $userObject.Name
    $password = $userobject.password
    #Generate a first initial lastname structure for username 
    $firstname , $lastname = $name.split(" ")
    $username = ($firstname[0] +$lastname).ToLower()
    $SamAccountName = $username
    $principalname = $username
    
    #Actually create AD user object
    New-ADUser -Name $name -GivenName $firstname -Surname $lastname -SamAccountName $SamAccountName -UserPrincipalName $principalname@$Global:Domain -AccountPassword (ConvertTo-SecureString $password -AsPlainText -Force) -PassThru |enable-adaccount

    foreach($group_name in $userObject.groups){
        try{
            Get-ADGroup -identity $group_name.
            AD-ADgroupmember -identity $group_name -members $username
        }catch [Microsoft.ActiveDirectory.Management.ADIdentityNotFoundException]{
            Write-Output "User $name not added to group $group_name because it does not exist"
        }
        
    }
}

    Write-Output $userObject



$json = (Get-Content $JsonFile | ConvertFrom-Json)

$Global:Domain = $json.domain


foreach($group in $json.groups){
   
    CreateAdGroup $group
}


foreach($user in $json.users){
    CreateAdUser($user)
}
