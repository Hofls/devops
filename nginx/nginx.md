# Nginx

## Reverse proxy. Ubuntu
#### 1. Run http server
* Run default http server `nohup python3 -m http.server &`
* Check if it is running `curl localhost:8000`
* Check that http port is free `netstat -tulpn | grep :80`

#### 2. Pass requests from port 80 to another port (or server)
* Install nginx `apt install nginx`
* Check that http port is busy `netstat -tulpn | grep :80`
* Check that nginx is working correctly (should show "Welcome to nginx!"):
    * `curl localhost`
    * Open in browser http://YOUR_SERVER_IP/
* Go to nginx dir `cd /etc/nginx `
* Open up config to edit `nano nginx.conf`
* Insert text in `http` section, so it looks like this:
```	
http {
    #It is useful when you have multiple http applications on one server, so each app has its own location. E.g. prometheus, grafana, jenkins, etc
        server {
                location /local-serv/ {
                        proxy_pass http://localhost:8000/;
                }
                #if you need to hide location behind password, generate it with htpasswd util
                location /protected/ {
                        proxy_pass http://github.com/;
                        auth_basic "git-usr";
                        auth_basic_user_file /etc/apache2/htpasswd;
                }
        }
}
```
* Save, exit the text editor
* Reload nginx configuration `service nginx reload`
* Check that everything is working:
    * http://YOUR_SERVER_IP/local-serv/ should show directory tree
    * http://YOUR_SERVER_IP/protected/ should redirect to github, or show login form (if you configured `htpasswd`)
