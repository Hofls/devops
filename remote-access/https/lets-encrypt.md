#### Info
* Let's Encrypt uses certbot to issue certificates
* Detailed [certbot instructions](https://certbot.eff.org/)
* Works only for domain names (not for IP addresses)
    * Easy way to get domain name - `Azure -> Create VM -> DNS Name`

#### Getting started (Nginx)
* apt install nginx`
* `apt update; apt install snapd`
* `snap install core; snap refresh core`
* `snap install --classic certbot`
* `certbot --nginx`
* Open `http://your_site_url`, `https://your_site_url`
