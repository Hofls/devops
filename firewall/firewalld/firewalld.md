#### Info
* `Firewalld` - front-end to iptables

#### Getting started
* Install - `apt update && apt install firewalld`

#### Port forwarding
* Allow ip forwarding in system kernel (not sure if necessary):
    * `nano /etc/sysctl.conf`, modify attribute:
        * `net.ipv4.ip_forward=1`
    * Apply changes - `sysctl -p /etc/sysctl.conf`
* Check rules list - `firewall-cmd --list-all`
* Add new rule:
    * `firewall-cmd --permanent --zone=public --add-port=7777/tcp`
    * `firewall-cmd --zone=public --permanent --add-forward-port=port=7777:proto=tcp:toport=8000:toaddr=138.120.15.70`
* Remove old rule:
    * `firewall-cmd --permanent --zone=public --remove-port=7777/tcp`
    * `firewall-cmd --zone=public --permanent --remove-forward-port=port=7777:proto=tcp:toport=8000:toaddr=138.120.15.70`
* Reload - `firewall-cmd --reload`

#### Port forwarding. Problems
* Port forwarding for kubernetes (6443)
    * You have configured port forwarding for 6443, changed `server:` in Kubeconfig
    * But error appears - `Unable to connect to the server: x509: certificate is valid for...`
    * Fix - replace `certificate-authority-data: ...` with `insecure-skip-tls-verify: true`
