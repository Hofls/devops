### CentOS / Ubuntu
* Install dependencies:
    * CentOS - `yum check-update && yum install ppp && yum install expect`
    * Ubuntu - `apt update && apt install ppp && apt install expect`
* Check dependencies:
    * `pppd --version`
    * `expect -v`
* Copy files to server:
    * `chmod 777 /opt`
    * Copy folder `forticlientsslvpn` to server folder `opt`
         * `chmod 777 /opt/forticlientsslvpn/64bit/forticlientsslvpn_cli`
         * `chmod 777 /opt/forticlientsslvpn/64bit/helper/setup.linux.sh`
    * Copy [connect.sh](connect.sh) to server folder `opt`
        * `chmod 777 /opt/connect.sh`
    * `cp /opt/symiga.pfx /opt/forticlientsslvpn/64bit/helper`
    * `cp /opt/connect.sh /opt/forticlientsslvpn/64bit/helper`
* Setup & run forti:
    * `cd /opt/forticlientsslvpn/64bit/helper`
    * `./setup.linux.sh`, agree with license terms (scroll with `z`)
    * `./connect.sh`
    * Wait for `STATUS::Tunnel running`

### Docker
* Prerequisites: everything from CentOS / Ubuntu
* `docker run -dit --volume /opt:/opt ubuntu`
* `docker exec -it 01285e bash`
* `apt update && apt install pptp-linux && apt install expect`
* `cd /opt/forticlientsslvpn/64bit/helper`
* `./connect.sh`

### Ubuntu. Second way
* Disclaimer: this instruction isn't fully working, leads to an error
    * `Could not authenticate to gateway. Please check the password, client certificate, etc.s`
* Install:
    * `apt update && apt install network-manager-fortisslvpn`
    * `openfortivpn --version`
* Convert .pfx to .pem:
    * `openssl pkcs12 -in semynga.pfx -out semynga.pem -nodes`
* Run:
    * `openfortivpn 32.213.143.16:10443 -u semynga -p qwerty --user-cert=semynga.pem -v`
    * After first run - error appears, copy `--trusted-cert` from error
    * `openfortivpn 32.213.143.16:10443 -u semynga -p qwerty --user-cert=semynga.pem -v --trusted-cert dsi23no8dkns55qa3c7djoi3df`
