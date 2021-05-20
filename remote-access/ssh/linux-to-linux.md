# Connect from one linux server to another
## Generate SSH keys:
* `ssh-keygen -t rsa`
    * keys located in `cd ~/.ssh`

## Connect to remote server via SSH:
* On remote server:
	* Add public key to `authorized_keys` in `cd ~/.ssh/`
* On local server:
    * Execute: `ssh hofls@121.154.23.15`

## Get file `/opt/getme.txt` from remote server
* On remote server:
	* Add public key to `authorized_keys` in `cd ~/.ssh/`
	* Create file `/opt/getme.txt`
* On local server:
    * Create directory `/opt/files-from-remote`
    * Execute:
        ```
        scp \
        hofls@123.243.32.145:/opt/getme.txt \
        /opt/files-from-remote/
        ```
  
## Send file `/opt/sendme.txt` to remote server
* On remote server:
	* Add public key to `authorized_keys` in `cd ~/.ssh/`
	* Create directory `/opt/inbox` (with permissions - chmod)
* On local server:
    * Create file `/opt/sendme.txt`
    * Execute:
        ```
        scp \
        /opt/sendme.txt \
        hofls@123.243.32.145:/opt/inbox/
        ```
## Debug:
* Set `LogLevel DEBUG3` in `/etc/ssh/sshd_config`
* Restart - `systemctl restart sshd`
* Try to connect
* Look at logs - `cat /var/log/auth.log` or `cat /var/log/secure`
