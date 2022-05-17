### Port forwarding (Windows)
* Use case:
    * Windows server (143.213.154.177) has vpn and access to company website.
    * You want to access protected website from your PC.
* Web server:
    * Install python, add python folder to environment variables (PATH)
    * Run server - `python -m http.server 8000`
    * Open in browser - http://localhost:8000/
    * To get server IP (guest) in VMware:
         * `ipconfig /all`, look for something like:
         ```
         Ethernet adapter Ethernet0
            IPv4 Address. . . . . . . . . . . : 143.213.154.177
         ```
    * Open in browser - http://143.213.154.177:8000
        * If unable to connect - try to disable firewall on server, or add rules
* Port forwarding:
    * Preparations:
        * `netsh interface ipv4 install` (not sure if necessary)
        * `netsh interface ipv6 install`
            * If appears error `ipv6 install was not found` then it's OK, ipv6 installed by default 
        * `Task manager` -> `Services` -> `iphlpsvc` or `IP Helper` -> `Turn on` or `restart`
    * Forward port:
        * `netsh interface portproxy add v4tov4 listenport=8111 connectport=8000 connectaddress=localhost`
        * If made a mistake - `netsh interface portproxy delete v4tov4 listenport=8111`
        * To show all ports - `netsh interface portproxy show all`
    * Test:
        * Open in browser:
            * http://localhost:8111
            * http://143.213.154.177:8111
        * If unable to connect - try to disable firewall on the server, or add rules
