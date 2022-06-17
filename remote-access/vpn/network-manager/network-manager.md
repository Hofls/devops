### Info
* Network manager - alternative to custom VPN clients (e.g. checkpoint)

### Common checks:
* `journalctl -f -u ipsec`, then run VPN
    * May show errors:
        * Wrong IP address - "Connection refused"
        * Wrong encryption algorithm - "ike string error: IKE DH algorithm 'modp1024Z' is not recognized"
        * Wrong shared key - "received 1 malformed payload notifies"
        * You need to disable PFS - "ignoring informational payload INVALID_KEY_INFORMATION"
        * Everything is OK (ignore it) - "warning: could not open include filename: '/etc/ipsec.d/*.conf'"
    * Other problems:
        * If VPN not connecting for no apparent reason, check `/etc/selinux/config`
            * Should have `SELINUX=enforcing`
* `nmcli device status`
    * At least couple of connections should be managed
* `journalctl -f -u NetworkManager.service`, then run VPN
    * Look at "Ubuntu" section
* After connecting to VPN:
    * `nmcli connection` (connection with type-vpn should appear)
    * `curl ifconfig.me` (ip should change)
    * `ping` / `telnet` previously unavailable server 
    
### VPN Configuration
* In GUI:
    * Activities -> Settings -> Network > VPN -> Add -> L2TP
    * Main - Fill gateway, username, password
    * PPP Options - PAP, Check all in compression, Send PPP echo packets
    * IPsec Options - Pre-Shared key, phase1 algorithm (aes128-sha1-modp1024), phase2 algorithm (aes128-sha1)
        * Also may be necessary to disable PFS
* In CLI:
    * Auto reconnect:
        * Main way (todo - figure out if its working)
            * Configure:
                * `nmcli connection modify "VPN 1" connection.autoconnect-retries 0`
                * `nmcli connection modify "VPN 1" vpn.persistent yes`
            * Check parameters:
                * `nmcli -f connection.autoconnect-retries con show "VPN 1"`
                * `nmcli -f vpn.persistent con show "VPN 1"`
        * Other ways (not really working):
            * 1 - `nmcli connection modify "VPN 1" connection.autoconnect yes`
            * 2 - `nm-connection-editor` -> select main network connection -> `General` -> `Automatically connect to VPN when using this connection`

### CentOS 7. Network manager VPN (working!)
* Prerequisites - install [centos + rdp](../../rdp/rdp.md)
* Install network manager:
    * `yum install -y epel-release` 
        * To avoid error "No package NetworkManager-l2tp-gnome available."
    * `yum install NetworkManager-l2tp-gnome`
* Configure VPN (look at "VPN Configuration")

### Ubuntu. Network manager VPN (not really working)
* Prerequisites - install [ubuntu + rdp](../../rdp/rdp.md)
* Install network manager:
    * `apt update && apt install -y network-manager-l2tp network-manager-l2tp-gnome`
* Configure VPN (look at "VPN Configuration")
* Problem - `nmcli device status` doesn't have managed connections
    * Solution - look at (State "Unmanaged" -> State "Connected")

### Ubuntu. State "Unmanaged" -> State "Connected" (is it useful?)
* Notice - Centos 7 doesnt have this problem (network manager used by default)
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