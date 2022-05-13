# Apache2 - Apache web server

## Reverse proxy. Ubuntu
Use case - single server has a bunch of different apps running, each on its own port.
If that's not the case - just make your only app listen on http port (80).
#### 1. Run http server
* Run default http server `nohup python3 -m http.server 8000 &`
    * Or `nohup python -m SimpleHTTPServer 8000 &`
* Check if it is running `curl localhost:8000`
* Check that http port is free `netstat -tulpn | grep :80`

#### 2. Pass requests from port 80 to another port (or server)
* Install apache2 `apt install apache2`
* Check that http port is busy `netstat -tulpn | grep :80`
* Check that apache2 is working correctly (should show "Apache2 Default Page"):
    * `curl localhost`
    * Open in browser http://YOUR_SERVER_IP/
* Enable http modules:
    * `a2enmod proxy`
    * `a2enmod proxy_http`
* Create new configuration:
    * `cd /etc/apache2/sites-available`
    * `touch sample.conf`
    * Insert text in the file:
    ```
    <VirtualHost *:80>
        <Location /external>
            ProxyPass http://example.com
            ProxyPassReverse http://example.com
        </Location>
        <Location /files>
            ProxyPass http://localhost:8000
            ProxyPassReverse http://localhost:8000
        </Location>
    </VirtualHost>
    ```
* Disable old configuration `a2dissite 000-default.conf`
* Enable new configuration `a2ensite sample.conf`
* Restart web server `systemctl restart apache2`
* Check that proxypass is working correctly:
    * `curl localhost/external`
    * `curl localhost/files`
    * Open in browser http://YOUR_SERVER_IP/external
    * Open in browser http://YOUR_SERVER_IP/files

## Etc
* Send all traffic trough http proxy:
    *
    ```
    <VirtualHost *:80>
        ProxyRemote * http://11.231.4.145:3128
        <Location /external>
            ProxyPass http://example.com
            ProxyPassReverse http://example.com
        </Location>
    </VirtualHost>
    ```
    * `localhost/external` will get example.com, via proxy 11.231.4.145
