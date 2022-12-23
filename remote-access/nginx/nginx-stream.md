# Nginx stream

### Info
* Stream is for tcp/udp protocols (transport OSI layer)
* For http-specific features (e.g. `/location`) user `http {` instead of `stream {`
* Some params differ from http:
    * `proxy_timeout 5s;` instead of `proxy_read_timeout 5s;`

### Getting started
* Run http server, install [nginx](nginx.md)
* Configure nginx:
```
load_module /usr/lib/nginx/modules/ngx_stream_module.so;
events {
}
stream {
        server {
                listen 8055;
                proxy_pass localhost:8000;
        }
}
```
* Open in browser `http://YOUR_SITE_IP:8055`, should show directory list
