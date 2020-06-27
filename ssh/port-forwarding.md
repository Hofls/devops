## SSH Tunneling (Port Forwarding)
Use case - app is running on a server, has web-interface on localhost. For some reason you cant open it to outside world.
#### Algorithm:
* Create SSH tunnel in `PUTTY`:
    * Go to `Connection` => `SSH` => `Tunnels`, set values
        * `Destination - Dynamic`
        * `Source port - 9999`
        * Press `Add`
    * Go to `Session`, set Host Name (or IP address)
        * Save session
        * Open connection
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
