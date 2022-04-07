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

### Problems/Solutions
* If after connecting to vpn - you lose access to previously available resource (e.g. timeout):
    * Turn off vpn
    * `ping registry.someit.com`, get ip (e.g. 17.211.56.173)
    * `nano /etc/hosts`, insert: `17.211.56.173 registry.someit.com`
* All traffic goes through VPN, but you need to access 133.211.7.232 without VPN (directly):
    * Find non-vpn gateway - `ip route list`
        * Look for something like `default via 172.18.0.1 dev eth0`
    * Add new route (avoiding VPN)
        * `ip route add 133.211.7.232 via 172.18.0.1`
    * If made a mistake - `ip route del 133.211.7.232`
