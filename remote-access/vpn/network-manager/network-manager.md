### CentOS 7. Network manager VPN (not really working)
* Prerequisites - install [centos + rdp](../../rdp/rdp.md)
* Install network manager:
    * `yum install NetworkManager-l2tp-gnome`
* Configure VPN (look at Ubuntu configuration)

### Ubuntu. Network manager VPN (not really working)
* Prerequisites - install [ubuntu + rdp](../../rdp/rdp.md)
* Install network manager:
    * `apt update && apt install -y network-manager-l2tp network-manager-l2tp-gnome`
* Configure VPN:
    * Activities -> Settings -> Network > VPN -> Add -> L2TP
    * Main - Fill gateway, username, password
    * PPP Options - PAP, All in compression, Send PPP echo packets
    * IPsec Options - Shared key, phase1 algorithm (aes128-sha1-modp1024), phase2 algorithm (aes128-sha1)
* Check:
    * `curl ifconfig.me`
    * `ping` / `telnet` previously unavailable server 
    * `journalctl -f -u NetworkManager.service`

### Ubuntu. State "Unmanaged" -> State "connected"
* Disclaimer - Centos 7 doesnt have this problem (network manager used by default)
* `apt install network-manager`
* `journalctl -f -u NetworkManager.service`
    * Has errors `Error: failed to open /run/network/ifstate`
    * Look at hint `cat /etc/network/interfaces`
    * Fix - `apt install ifupdown`
* `nmcli device status`
    * Looks bad - everything is unmanaged
    * `nano /etc/NetworkManager/NetworkManager.conf`, replace text
        ```
        [ifupdown]
        managed=true
      
        [keyfile]
        unmanaged-devices=none
        ```
    * `systemctl restart NetworkManager.service`
* Check state again `nmcli device status`
* Weird stuff - left click on network-adapter may be [necessary](https://github.com/Chadsr/NordVPN-NetworkManager/issues/62)