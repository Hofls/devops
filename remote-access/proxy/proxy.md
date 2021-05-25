## Tinyproxy
##### Installation
* Server side:
    * `apt update`
    * `apt install tinyproxy -y`
    * `nano /etc/tinyproxy/tinyproxy.conf`
        * Comment out `Allow 127.0.0.1`
    * `service tinyproxy restart`
* Client side:
    * Install `Proxy Helper` (extension for `Google chrome`)
    * Set server IP, port 8888, activate `http proxy`
    * [check your IP](https://api.ipify.org/?format=json)
    
##### Basic auth
* Server side:
    * `nano /etc/tinyproxy/tinyproxy.conf`
        * Comment out `BasicAuth`, set user/password
    * `service tinyproxy restart`
* Client side:
    * Set user/password
    * [check your IP](https://api.ipify.org/?format=json)

## Squid
##### Installation
* Server side:
    * `apt install squid`
    * `nano /etc/squid/squid.conf`
        * Add `http_access allow all` after `http_access allow localnet`
    * `systemctl restart squid`
* Client side:
    * Install `Proxy Helper` (extension for `Google chrome`)
    * Set server IP, port 3128, activate `http proxy`
    * [check your IP](https://api.ipify.org/?format=json)

##### Basic auth
* Super bloated. Better use `Tinyproxy`
