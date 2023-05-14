#### Getting started
* Server side:
    * `cd /opt`
    * `apt update && apt install openvpn curl`
    * `curl -O https://raw.githubusercontent.com/Angristan/openvpn-install/master/openvpn-install.sh`
    * `chmod +x openvpn-install.sh`
    * `./openvpn-install.sh`
        * Public IP - had to replace it, by default showed internal IP
        * Client name - clint
    * Download `/home/hofls/clint.ovpn`
* Client side (Local VM / Real PC):
    * Notice: not really working on cloud VM (interrupts ssh connection)
    * `apt update && apt install openvpn network-manager-openvpn`
    * Copy `clint.ovpn` to `/etc/openvpn/client/clint.ovpn`
    * Run VPN:
        * Check your IP - `curl ifconfig.co` (shows client IP)
        * Run VPN `openvpn /etc/openvpn/client/clint.ovpn`
        * Check your IP - `curl ifconfig.co` (shows server IP)
