### Info
* `VPN` (Virtual Private Network) - allows secure connection to another computers over the internet
* `Private network` - e.g. computers in an office have LAN, but no access to internet
    * They can communicate only with each other (private)
* `VPN server` acts as gateway to internet 
    * Example - you are in Africa, VPN server in America, your http requests will come from an American IP address
* `Use cases`:
    * Being part of big corporate private network
    * Ability to access geo restricted services
    * Secure data exchange (data is encrypted)
* After connecting to a VPN - you get new IP address, available only for VPN network
    * Windows - `ipconfig/all`, look for something like `Unknown adapter Local Area Connection`
    * Linux - `ifconfig -a`

### Problems/Solutions
* Disconnect after initialization sequence:
    * Logs:
    ```
    Initialization Sequence Completed
    event_wait : Interrupted system call (code=4)
    SIGTERM[hard,] received, process exiting
    ```
    * May mean that VPN with this user/password is already running on another server (you have to stop it manually)
* If after connecting to vpn - server becomes unavailable (ssh disconnects)
    * `ip route`
        * Look for default gateway, something like `default via 10.129.27.1 dev eth0`
        * Look for alternative, something like `10.129.0.0/24 dev eth0`
    * Add new route (alternative -> default):
        * `ip route add 10.129.0.0/24 via 10.129.27.1 dev ens192 metric 40`
    * Explanation: it works because after connection to VPN new gateways appear, but we need to use old one
* If after connecting to vpn - you lose access to previously available resource (e.g. timeout):
    * IP addresses with VPN and without VPN might be different (internal vs external)
    * Turn off vpn, `ping registry.someit.com`, get ip (e.g. 17.211.56.173)
    * `nano /etc/hosts`, insert: `17.211.56.173 registry.someit.com`
* All traffic goes through VPN, but you need to access 133.211.7.232 without VPN (directly):
    * Find non-vpn gateway - `ip route list`
        * Look for something like `default via 172.18.0.1 dev eth0`
    * Add new route (avoiding VPN)
        * `ip route add 133.211.7.232 via 172.18.0.1`
    * If made a mistake - `ip route del 133.211.7.232`
    * Important - solution is temporary (you have to add route again after restart)
* If you have server with VPN and proxy - look [here](../proxy/proxy.md) for problems
    * Use case - install VPN once, everybody can use it (e.g. team members, microservices, ci/cd scripts)
* Don't know which encryption algorithm to use?
    * Easy way:
        * Gather info about server-side VPN
        * `systemctl stop ipsec`
        * `ike-scan 148.238.155.44`
        * `systemctl start ipsec`
    Hard way:
        * [Execute script](https://github.com/nm-l2tp/NetworkManager-l2tp/wiki/Known-Issues#querying-vpn-server-for-its-ikev1-algorithm-proposals)
