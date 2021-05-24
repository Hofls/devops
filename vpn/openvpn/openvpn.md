#### On ubuntu server
* Make sure there is no access without VPN:
    * `curl http://INSERT_URL_HERE`
    * Should return `Could not resolve host`
* Install dependencies:
    * `apt update`
    * `apt install openvpn`
        * `openvpn --version`
    * `apt install resolvconf`
* Configure OpenVPN:
    * Copy [config](files/dt-config.conf) to `/etc/openvpn`
        * Replace IP address and certificates
    * Copy [password](files/passwd.conf) to `/etc/openvpn`
        * Replace login and password
* Run
    * `systemctl start openvpn@dt-config`
    * Test - `curl http://INSERT_URL_HERE`
    * Logs - `journalctl -f`
    
#### Inside docker container ubuntu server
* 
* 
* 
