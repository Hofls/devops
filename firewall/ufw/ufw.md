#### Info
* `UFW` (Uncomplicated Firewall) - simple front-end to iptables

#### Getting started
* Run http server:
    * `mkdir /opt/hello-world && cd /opt/hello-world`
    * `nohup python3 -m http.server 8000 &`
    * Open in browser `http://YOUR_SERVER_IP:8000` (will work)
* Turn on ufw:
    * `ufw enable`
    * Open in browser `http://YOUR_SERVER_IP:8000` (won't work, by default everything is disallowed)
* Allow connection to port 8000:
    * `ufw allow 8000`
    * Open in browser `http://YOUR_SERVER_IP:8000` (will work)
* Show all rules - `ufw status`
* Delete rule:
    * `ufw status numbered` (pick a number, lets say №1)
    * `ufw delete 1`

#### Useful commands
* Allow all connections to port 8000:
    * `ufw allow 8000`
* Show all rules:
    * `ufw status` / `iptables -S`
* Delete rule:
    * `ufw status numbered` (pick a number, lets say №1)
    * `ufw delete 1`
* Clear all rules:
    * `ufw reset`
* Allow access to ports 22, 80, 443. Drop everything else
    * `ufw allow 22`, `ufw allow 80`, `ufw allow 443`
* Allow access only for one IP address (e.g. only access from Proxy or VPN)
    * `iptables -A INPUT -s 174.123.44.85 -j ACCEPT`
    * `iptables -P INPUT DROP`
