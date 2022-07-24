## 02 Creating Users with powershell
1. Wrote a script inside of the Code folder to read a json file and create users and groups
2. I copied over the script and the json file to the domain controller using powershell
    - Once you create a session and you save it as a variable you can pass it into the copy-item to copy to another device 
```shell
Copy-Item .\gen_ad.ps1 -ToSession $session c:\windows\Tasks
```