### Domain name in local DNS (hosts file)
* On server:
    * Run http server - `python3 -m http.server 80`
* On your pc:
    * Add line to hosts file - `123.154.77.183 example.com`
    * Open `http://example.com/` in browser

### Subdomain (3rd level domain)
* On server:
    * Run http server - `nohup python3 -m http.server 80 &`
* Add subdomain
    * Open `https://freedns.afraid.org/`
    * Link `hello.moo.com` with `123.154.77.183`
* Check `http://hello.moo.com` from your pc / server (may have to wait for some time)

