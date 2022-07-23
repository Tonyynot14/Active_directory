## 01 Installing domain controller 

1. Use Sconfig to:
    -Change the hostname
    - Change the Ip address to static
    - Change the DNS server to our own IP address
2. Install the active directory windows feature
``` Shell
Install-windowsfeature AD-Domain-services -includemanagementtools
```