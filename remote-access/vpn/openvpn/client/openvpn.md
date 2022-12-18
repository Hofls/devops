#### On ubuntu
* Make sure there is no access without VPN:
    * `curl http://INSERT_URL_HERE`
    * Should return `Could not resolve host`
* Install dependencies:
    * On Ubuntu:
        * `apt update`
        * `apt install openvpn`
            * `openvpn --version`
        * `apt install resolvconf` (optional)
    * On OpenSUSE:
        * `zypper refresh`
        * `zypper in openvpn`
    * On CentOS:
        * `yum check-update`
        * `yum install epel-release -y`
        * `yum install openvpn`
* Configure OpenVPN:
    * Copy [config](files/dt-config.conf) to `/etc/openvpn`
        * Replace IP address and certificates
    * Copy [password](files/passwd.conf) to `/etc/openvpn`
        * Replace login and password
* Run
    * `systemctl start openvpn@dt-config`
    * Test - `curl http://INSERT_URL_HERE`
    * Logs - `journalctl -f`
* If VPN should always be running - look at `linux/other.md -> Systemd`

#### Etc
* To run two VPNs at the same time:
    * Run `addtap.bat` as admin:
        * C:\Program Files\TAP-Windows\bin
        * C:\ProgramData\Microsoft\Windows\Start Menu\Programs\OpenVPN\Utilities
    * Edit `hosts`:
        * C:\Windows\System32\drivers\etc
        * 14.12.44.122 wiki.som.asoc jira.som.asoc
* To use different DNS (no more hosts editing)
    ```
  	script-security 2
  	dhcp-option DNS 20.211.35.44
  	dhcp-option DOMAIN e27.pkz
    ```