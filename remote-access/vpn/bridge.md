### Info
* Use case:
    * Your company "Jarezo" has VPN, another company "Spiquo" has its own VPN too
    * You have to deploy product, push images/dependencies, work with app on Spiquo resources
    * In order to do that - you have to use vpn. Possible with vpn+proxy on server, but better use bridge.
* Bridge - connect two networks (Spiquo resources would by available with Jarezo VPN)

#### Implementation (Not complete)
* Install VPN on "Jarezo" server, make sure "Spiquo" resources are available (ping, telnet)
* Check routes: `ip route`
* Check network interface config: `ifconfig`
* Allow ip forwarding in system kernel:
    * `nano /etc/sysctl.conf`, modify attribute:
        * `net.ipv4.ip_forward=1`
    * Apply changes - `sysctl -p /etc/sysctl.conf`
* Add firewall rules:
    ```
    firewall-cmd --direct --permanent --add-rule ipv4 nat POSTROUTING 0 -o tun0 -j MASQUERADE
    firewall-cmd --direct --permanent --add-rule ipv4 filter FORWARD 0 -i ens192 -o tun0 -j ACCEPT
    firewall-cmd --direct --permanent --add-rule ipv4 filter FORWARD 0 -i tun0 -o ens192 -m state --state RELATED,ESTABLISHED -j ACCEPT
    systemctl restart firewalld
    ```
* Check everything again - `ip route`, `ifconfig`
* Ask admins to add route to this server
    * Prepare list of IPS that should use this route (e.g. ip of k8s, artifactory, jira)
