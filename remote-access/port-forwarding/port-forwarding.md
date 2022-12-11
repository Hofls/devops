### 1. Run http server
* Run default http server `nohup python3 -m http.server 8000 &`
    * Or `nohup python -m SimpleHTTPServer 8000 &`
* Check if it is running `curl localhost:8000`

### 2. Port-forwarding (redirect-traffic)
##### socat (tcp)
* `apt install socat`
* Redirect traffic from outside port 9090 to localhost:8000
    * `socat tcp-listen:9090,reuseaddr,fork tcp:localhost:8000`
##### iptables (tcp)
* Look [here](/firewall/iptables/port-forwarding.md)
##### firewalld (tcp)
* Look [here](/firewall/firewalld/firewalld.md)
##### windows (tcp)
* Look [here](../windows/port-forwarding.md)
##### apache2 (http)
* Look [here](../apache2/apache2.md)
##### nginx (http)
* Look [here](../nginx/nginx.md)
