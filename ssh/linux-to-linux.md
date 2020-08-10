# Connect from one linux server to another
## Connect to remote server via SSH:
* On remote server:
	* Add public key to `authorized_keys` in `cd ~/.ssh/`
* On local server:
    * Copy private key to `/opt/keys/`
    * Execute:
        ```
        ssh \
        -i /opt/keys/private.key \
        hofls@121.154.23.15
        ```

## Get file `/opt/getme.txt` from remote server
* On remote server:
	* Add public key to `authorized_keys` in `cd ~/.ssh/`
	* Create file `/opt/getme.txt`
* On local server:
    * Copy private key to `/opt/keys/`
    * Create directory `/opt/files-from-remote`
    * Execute:
        ```
        scp \
        -i /opt/keys/private.key \
        hofls@123.243.32.145:/opt/getme.txt \
        /opt/files-from-remote/
        ```
  
## Send file `/opt/sendme.txt` to remote server
* On remote server:
	* Add public key to `authorized_keys` in `cd ~/.ssh/`
	* Create directory `/opt/inbox` (with permissions - chmod)
* On local server:
    * Copy private key to `/opt/keys/`
    * Create file `/opt/sendme.txt`
    * Execute:
        ```
        scp \
        -i /opt/keys/private.key \
        /opt/sendme.txt \
        hofls@123.243.32.145:/opt/inbox/
        ```
