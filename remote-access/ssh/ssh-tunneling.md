## SSH Tunneling (Port Forwarding)
#### Google chrome
* Use case - app is running on a server, has web-interface on localhost. For some reason you cant open it to outside world.
* Create SSH tunnel in `PUTTY`:
    * Go to `Connection` => `SSH` => `Tunnels`, set values
        * `Source port` - 9999
        * Pick `Dynamic`
    * Go to `Session`, set Host Name (or IP address)
        * Save session, open connection
* Create `Google Chrome` shortcut
    * Change run parameters, so they look like this
        * `"C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" --proxy-server="socks5://127.0.0.1:9999"`
    * Open `Google Chrome`
* Check your ip address on any web-service, to make sure it is changed
* To access remote localhost
    * Add following line to `/etc/hosts` file on the server
        * `127.0.0.1 remote.host`
    * To access app running on a remote localhost, on port 8081, use:
        * http://remote.host:8081

#### RDP
* Use case - server has VPN, and access to another rdp server (20.44.32.54:3389)
* Create SSH tunnel in `PUTTY`:
    * Go to `Connection` => `SSH` => `Tunnels`
        * `Source port` - 9999
        * `Destination` - 20.44.32.54:3389
    * Go to `Session`, set Host Name (or IP address)
        * Save session, open connection
* Open rdp client, connect to `127.0.0.1:9999`
    * All traffic will go trough server with VPN (via ssh), straight to `Destination`
