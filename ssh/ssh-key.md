## Connect to server using ssh key
Use case - you got tired of entering password each time / want to improve level of security
#### Algorithm:
* Generate ssh keys (private and public)
    * On Windows - use `PuTTYgen.exe`
    * On Linux - `ssh-keygen -t rsa`
* Add public key to authorized list on server
    * `cd ~/.ssh/`
    * Copy public key into file `authorized_keys`
    * Public key should look like `ssh-rsa AAAAB3N...2DA key-comment`
* Connect via Putty
    * Add private key in `Connection => SSH => Auth => Private key file for authentication:`
    * Go to `Session`, set Host Name (or IP address)
        * Save session
        * Open connection