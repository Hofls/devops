#### Info
* `iptables` - allows modification of IP packet filter rules (in the Linux kernel firewall)
* Notice №1: 
    * All changes are temporary (work until reboot)
    * To make them permanent, execute `/sbin/iptables-save`
* Notice №2:
    * Kernel checks rules in order, until it finds rule that allows/disallows packet/connection

#### Getting started
* Run http server:
    * `cd /opt/hello-world`
    * `nohup python3 -m http.server 8000 &`
    * Open in browser `http://YOUR_SERVER_IP:8000` (will work, by default everything is allowed)
* Black all connections to port 8000:
    * `iptables -A INPUT -p tcp --dport 8000 -j DROP`
    * Open in browser `http://YOUR_SERVER_IP:8000` (won't work, ERR_CONNECTION_TIMED_OUT)
* Show all rules - `iptables -S`
* Delete rule:
    * `iptables -L --line-numbers` (pick a number and category, lets say INPUT №1)
    * `iptables -D INPUT 1`
    * Open in browser `http://YOUR_SERVER_IP:8000` (will work)
    
#### Useful commands
* Black all connections to port 8000:
    * `iptables -A INPUT -p tcp --dport 8000 -j DROP`
* Show all rules:
    * `iptables -S`
    * `iptables -t nat -L` (NAT only)
* Delete rule:
    * `iptables -L --line-numbers` (pick a number and category, lets say INPUT №1)
    * `iptables -D INPUT 1`
* Clear all currently configured rules:
    * `iptables -F`
    * `iptables -t nat -F` (NAT only)
* Allow access to ports 22, 80, 443. Drop everything else
    * `iptables -t filter -I INPUT -p tcp -m multiport --dports 22,80,443 -j ACCEPT`
    * `iptables -t filter -A INPUT -p tcp -j DROP`
* Allow access only for one IP address (safe way, greatly reduces attack surface)
    * `iptables -A INPUT -s 174.123.44.85 -j ACCEPT`
    * `iptables -P INPUT DROP`
