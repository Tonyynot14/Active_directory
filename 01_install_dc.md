## 01 Installing domain controller 

1. Use Sconfig to:
    -Change the hostname
    - Change the Ip address to static
    - Change the DNS server to our own IP address
2. Install the active directory windows feature
``` Shell
Install-windowsfeature AD-Domain-services -includemanagementtools
Import-module addsdeployment
install-addsforest
```
- You have to change the IP address for the DNS from the loopback after domain restart
- This gets your current dns server settings for all
``` Shell
Get-DnsClientServerAddress 
```
- This sets DNS client server address 
``` shell
    Set-DnsClientServerAddress -interfaceindex {number_previous} -ServerAddresses IP of domain controller
 ```
 

 ### Joining the workstation to the Domain

 ```
Add-computer -domainname xyz.com -Credential (get-credentials) -force -restart
 ```