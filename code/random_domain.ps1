param([Parameter(Mandatory=$true)] $OutputJsonFile)

$groups = @()
$num_groups = 10

### Each of these loads from a github repo and downloads everytime the script is ran. If they are removed or changed it could break things    
### First name has return carriage and also newlines it would seem so removed them both
$first_names =  [System.Collections.ArrayList]  ((Invoke-WebRequest https://raw.githubusercontent.com/hippy2094/random-name-generator/master/firstnames.txt -useBasicParsing).content.trim() -split "`r`n")
$last_names =[System.Collections.ArrayList]  ((Invoke-WebRequest https://raw.githubusercontent.com/hippy2094/random-name-generator/master/surnames.txt -useBasicParsing).content -split "`n")
$passwords = [System.Collections.ArrayList] ((Invoke-WebRequest https://gist.githubusercontent.com/roycewilliams/4003707694aeb44c654bf27a19249932/raw/7afc95e02df629515960a3e45109e6f88db3a99e/rockyou-top15k.txt -useBasicParsing).content.trim() -split "`n")
##### Have to remove blank lines from the file that is loaded. Had to cast it back to a arraylist because the trim changed the type
$passwords =[System.Collections.ArrayList] ($passwords | ? {$_.trim() -ne "" })
$group_names= [System.Collections.ArrayList] (Get-Content -Path "Data\group_names.txt")

for($i = 0; $i -lt $num_groups; $i++ ){
    $new_group = Get-Random -InputObject $group_names
    $groups += @{ "name" = "$new_group"}
    $group_names.Remove($new_group)
}

$num_users = 100
$users = @()
for($i = 0; $i -lt $num_users; $i++ ){
    $first_name =  Get-Random -InputObject $first_names
    $last_name = Get-Random -InputObject $last_names
    $password =  Get-Random -InputObject $passwords
    $new_user=  @{
        "name"="$first_name $last_name"
        "password"="$password"
        "groups"= , @(Get-Random -InputObject $groups).name

        
     }
     $users += $new_user

    $first_names.Remove($first_name)
    $last_names.Remove($last_name)
    $passwords.Remove($password)

}

 @{
    "domain" = "XYZ.com"
    "groups" = $groups
    "users" = $users
}| ConvertTo-Json | Out-File $OutputJsonFile