### Info
* Use case:
    * Your company "Jarezo" has VPN, another company "Spiquo" has its own VPN too
    * You have to deploy product, push images/dependencies, work with app on Spiquo resources
    * In order to do that - you have to use vpn. Possible with vpn+proxy on server, but better use bridge.
* Bridge - connect two networks (Spiquo resources would be available with Jarezo VPN)

#### Implementation
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
  * If you need multiple VPNs - add firewall rules for each (replace `tun0` with `tun1`, `tun2` etc)
    * In openvpn, you can set tun name in config file (replace `dev tun` with `dev tun1`)
* Check everything again - `ip route`, `ifconfig`
* Test from another server in the same network:
    * Resource not available:
        * `curl https://hidden-behind-vpn.com` - Failed to connect to port 443: No route to host
    * `ip route add 13.12.233.222 via 16.154.33.122`
        * Error `Nexthop has invalid gateway` means servers not in the same network
        * Error `Network is unreachable` means you are in the different network
        * Error `ip: RTNETLINK answers: Operation not permitted` means you are inside of a container. Add missing capabilities (k8s):
            ```
            securityContext:
              capabilities:
                add: ["NET_ADMIN"]
            ```
    * Now all requests to `13.12.233.222` will go through server with vpn (`16.154.33.122`)
        * `curl https://hidden-behind-vpn.com` - Success!
    * `ip route del 13.12.233.222`
* Ask admins to add route to this server
    * Prepare list of IP addresses that should be available through this route (e.g. ip of k8s, artifactory, jira)
