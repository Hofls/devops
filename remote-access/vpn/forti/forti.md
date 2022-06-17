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
    * Check passwords in `conect.sh`:
        * Should start with `--` to ignore all weird symbols in password
        * Should end with `\r` (next line)
    * `mv /opt/symiga.pfx /opt/forticlientsslvpn/64bit/helper`
    * `mv /opt/connect.sh /opt/forticlientsslvpn/64bit/helper`
* Setup & run forti:
    * `cd /opt/forticlientsslvpn/64bit/helper`
    * `./setup.linux.sh`, agree with license terms (scroll with `z`)
        * May also show error message, if not all dependencies installed
    * `./connect.sh`
    * Wait for `STATUS::Tunnel running`

### Docker
* Prerequisites 
    * Copy files to server (look at "CentOS / Ubuntu")
* Install & run:
    * `docker run -dit --volume /opt/forticlientsslvpn:/opt/forticlientsslvpn --privileged --name fortivpn ubuntu`
    * `docker exec -it 01285e bash`
    * `apt update && apt install ppp expect iproute2`
    * `cd /opt/forticlientsslvpn/64bit/helper`
    * `./setup.linux.sh`
    * `./connect.sh`
    * Wait for `STATUS::Tunnel running`
* Save your work:
    * `docker commit 01285e ubuntu:forti`
* Use vpn from another container:
    * `docker run -dit --privileged --net=container:fortivpn ubuntu`
    * `docker exec -it s3kd8 bash`
    * `curl https://IP_AVAILABLE_WITH_VPN/`
* If VPN is working:
    * Remove containers (kill && rm)
    * Create Dockerfile:
        ```
        FROM ubuntu:forti
        CMD cd /opt/forticlientsslvpn/64bit/helper && ./connect.sh
        ```
    * `docker build --tag forti-dockerfile .`
    * `docker run --volume /opt/forticlientsslvpn:/opt/forticlientsslvpn --privileged -dit --name fortivpn forti-dock`
* Use vpn from another container (again)

### Ubuntu. Second way
* Notice: this instruction isn't fully working, leads to an error
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
