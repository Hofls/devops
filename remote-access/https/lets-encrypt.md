#### Info
* Let's Encrypt uses certbot to issue certificates
* Detailed [certbot instructions](https://certbot.eff.org/)
* Works only for domain names (not for IP addresses)
    * Easy way to get domain name - `Azure -> Create VM -> DNS Name`

#### Install certbot
* Install snapd
    * `apt install snapd`
* Install certbot
    * `snap install core; snap refresh core`
    * `snap install --classic certbot`

#### Nginx. Getting started
* Install nginx
    * `apt update; apt install nginx`
* Run certbot
    * `certbot --nginx`
* Open `http://your_site_url`, `https://your_site_url`
* Test automatic renewal
    * `certbot renew --dry-run`
* Configure nginx
    * Edit `nano /etc/nginx/sites-available/default`
    * Find `# managed by Certbot`, that's location to insert stuff from [nginx.md](../nginx/nginx.md) (e.g. `location`)

#### Apache2. Getting started
* TODO

#### HAProxy. Getting started
* TODO
