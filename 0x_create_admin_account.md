## Create a random admin accoutn to login with

1. Create a OU for the user to fall into
``` shell
New-ADorganizationalunit -name Tech
```
2. Create a new user and set password and enable . This requires user input for the Read-host portion 
```shell 
New-Aduser -name Tony -path "OU=Tech,DC=xyz,dc=com" -accountpassword (Read-Host -AsSecureString "AccountPassword") -enable $true
```

3. Add-ADgroupmemeber -identity "Domain Admins"   -members Tony