#### Port forwarding (routing)
* Essence: all packets coming to your server (84.212.150.105:80), should be sent to http://example.com (93.184.216.34:80)
* Use case: 
    * Your server has installed VPN, some web sites only available through it
    * Edit hosts on client, to send traffic through this server
        `84.212.150.105 example.com`
    * It's an alternative to proxy and ip routes
* On server 84.212.150.105:
    * Sometimes it is necessary to disable frontends for iptables (e.g. firewalld, ufw)
        * Check status - `systemctl status firewalld`, disable - `systemctl stop firewalld`
    * `echo 1 > /proc/sys/net/ipv4/ip_forward`
        * If not working - try adding `net.ipv4.ip_forward=1` to `/etc/sysctl.conf`
    * Configure iptables:
        * Make sure there is no pre-existing NAT rules: `iptables -t nat -L`
            * To clean - `iptables -t nat -F`
        * `iptables -t nat -A PREROUTING -p tcp --dport 80 -j DNAT --to-destination 93.184.216.34:80`
        * `iptables -t nat -A POSTROUTING -p tcp --dport 80 -j MASQUERADE`
        * Also works with https (just replace 80 with 443)
* On client:
    * `nano /etc/hosts`
        * Insert `84.212.150.105 example.com`
    * `curl http://example.com`
* Sources:
    * [PREROUTING](https://serverfault.com/questions/586486/how-to-do-the-port-forwarding-from-one-ip-to-another-ip-in-same-network)
    * [POSTROUTING](https://stackoverflow.com/questions/51767216/iptables-forward-connection-timeout)
* Problems:
    * curl returns "(60) SSL: no alternative certificate subject name matches target host name"
        * Means you specified wrong ip in iptables for host name
