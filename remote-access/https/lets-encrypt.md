#### Info
* Let's Encrypt uses certbot to issue certificates
* Detailed [certbot instructions](https://certbot.eff.org/)
* Works only for domain names (not for IP addresses)
    * Easy way to get domain name - `Azure -> Create VM -> DNS Name`

#### Getting started (Nginx)
* Install nginx
    * `apt update; apt install nginx`
* Install snapd
    * `apt install snapd`
* Install certbot
    * `snap install core; snap refresh core`
    * `snap install --classic certbot`
* Run certbot
    * `certbot --nginx`
* Open `http://your_site_url`, `https://your_site_url`
* Test automatic renewal
    * `certbot renew --dry-run`
