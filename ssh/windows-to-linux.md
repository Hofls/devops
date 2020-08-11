# Connect from windows machine to linux server
## Connect to server using ssh key
Use case - you got tired of entering password each time / want to improve level of security
#### Algorithm:
* Generate ssh keys (private and public)
    * On Windows - use `PuTTYgen.exe`
* Add public key to authorized list on server
    * `cd ~/.ssh/`
    * Copy public key into file `authorized_keys`
    * Public key should look like `ssh-rsa AAAAB3N...2DA key-comment`
* Connect via Putty
    * Add private key in `Connection => SSH => Auth => Private key file for authentication:`
    * Go to `Session`, set Host Name (or IP address)
        * Save session
        * Open connection
* Connect via WinSCP
    * Add private key in `Advanced... => Authentication => Private key file`
    * Set Hostname, Username, Password
    * Save session
    * Open connection

## Convert .ppk file (Putty, Windows) to OpenSSH format (Linux)
* `apt install putty-tools`
* Move to folder with `private.ppk` key
* `puttygen private.ppk -O private-openssh -o private.key`
