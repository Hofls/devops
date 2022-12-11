#### Info
* `Firewalld` - front-end to iptables

#### Getting started
* Install - `apt update && apt install firewalld`

#### Useful commands

#### Port forwarding
* Check rules list - `firewall-cmd --list-all`
* Add new rule:
    * `firewall-cmd --permanent --zone=public --add-port=7777/tcp`
    * `firewall-cmd --zone=public --permanent --add-forward-port=port=7777:proto=tcp:toport=8000:toaddr=138.120.15.70`
* Remove old rule:
    * `firewall-cmd --permanent --zone=public --remove-port=7777/tcp`
    * `firewall-cmd --zone=public --permanent --remove-forward-port=port=7777:proto=tcp:toport=8000:toaddr=138.120.15.70`
* Reload - `firewall-cmd --reload`
