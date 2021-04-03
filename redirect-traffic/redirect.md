### 1. Run http server
* Run default http server `nohup python3 -m http.server 8000 &`
    * Or `nohup python -m SimpleHTTPServer 8000 &`
* Check if it is running `curl localhost:8000`

### 2. Redirect traffic (Port-forwarding)
##### socat
* `apt install socat`
* Redirect traffic from outside port 9090 to localhost:8000
    * `socat tcp-listen:9090,reuseaddr,fork tcp:localhost:8000`
##### apache2
* Look [here](../apache2/apache2.md)
##### nginx
* Look [here](../nginx/nginx.md)
