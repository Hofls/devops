#### Info
* Haproxy - reverse proxy and load balancer

#### Getting started
* Install - `apt update && apt install haproxy`
* Check - `haproxy -v`, `systemctl status haproxy`
* Route traffic from port 80 to port 7894:
    * Run http server - `nohup python3 -m http.server 7894 &`
    * `nano /etc/haproxy/haproxy.cfg`, insert:
    ```
    frontend http-in
      bind *:80
      mode http
      default_backend python-srv
    
    backend python-srv
      mode http
      balance roundrobin
      server backend-server 127.0.0.1:7894 check
    ```
    * Apply changes - `systemctl restart haproxy`
    * Open in browser `http://YOUR_SERVER_IP:7894/`
