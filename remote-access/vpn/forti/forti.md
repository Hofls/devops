* Disclaimer: this instruction isn't fully working, leads to an error
    * `Could not authenticate to gateway. Please check the password, client certificate, etc.s`
* Install:
    * `apt update && apt install network-manager-fortisslvpn`
    * `openfortivpn --version`
* Conver .pfx to .pem:
    * `openssl pkcs12 -in semynga.pfx -out semynga.pem -nodes`
* Run:
    * `openfortivpn 32.213.143.16:10443 -u semynga -p qwerty --user-cert=semynga.pem`
    * After first run - error appears, copy `--trusted-cert` from error
    * `openfortivpn 32.213.143.16:10443 -u semynga -p qwerty --user-cert=semynga.pem --trusted-cert dsi23no8dkns55qa3c7djoi3df`
