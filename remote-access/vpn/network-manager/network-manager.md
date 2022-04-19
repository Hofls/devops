### Ubuntu. Network manager VPN
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
