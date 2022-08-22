# Connect from windows machine to linux server
## Connect to server using ssh key
Use case - you got tired of entering password each time / want to improve level of security
#### cmd -> ssh
* Generate new key pair (`.pem`)
    * e.g. - aws/azure, on instance launch
* Protect .pem file by limiting access
    * File -> Properties -> Security -> Advanced -> Disable inheritance -> Convert -> Remove all but Admin/System
* Go to .pem file directory, run `cmd`
* Execute `ssh -i "key.pem" root@ec2-3-134-141-212.us-east-2.compute.amazonaws.com`
#### Putty:
* Generate ssh keys (private and public)
    * On Windows - use `PuTTYgen.exe`
    * SSH-1 (RSA) is deprecated, better use Ed25519
* Add public key to authorized list on server
    * Make sure authorized_keys exist - `cat ~/.ssh/authorized_keys`
        * If doesnt exist: `mkdir ~/.ssh && chmod 700 ~/.ssh`
    * Copy public key into file `nano ~/.ssh/authorized_keys`
        * Public key should look like `ssh-rsa AAAAB3N...2DA key-comment`
* Connect via Putty
    * Add private key in `Connection => SSH => Auth => Private key file for authentication:`
    * Go to `Session`, set Host Name (or IP address)
        * Save session
        * Open connection
* Connect via WinSCP
    * Add private key in `Advanced... => Authentication => Private key file`
    * Set Hostname, Username
    * Save session
    * Open connection

## Convert .ppk file (Putty, Windows) to OpenSSH format (Linux)
* `apt install putty-tools`
* Move to folder with `private.ppk` key
* `puttygen private.ppk -O private-openssh -o private.key`
