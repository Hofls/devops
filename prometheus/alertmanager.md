### Info
* Receives alerts from Prometheus, sends them telegram/email/etc

### Install (on Server)
* `cd /opt`
* `wget https://github.com/prometheus/alertmanager/releases/download/v0.21.0/alertmanager-0.21.0.linux-amd64.tar.gz`
* `tar xvfz alertmanager-*.tar.gz`
* `cd alertmanager-*`
* `./alertmanager &`
* Check installation:
    * `curl localhost:9093`
    * `http://YOUS_SERVER_IP:9093` (open in web browser)
