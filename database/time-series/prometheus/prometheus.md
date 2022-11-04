### Info
* Time series database, used for event monitoring and alerting
* Based on pull model (each app should expose its metrics on endpoint, e.g. /metrics)

### Install (on Server)
* `cd /opt`
* `wget https://github.com/prometheus/prometheus/releases/download/v2.25.2/prometheus-2.25.2.linux-amd64.tar.gz`
* `tar xvfz prometheus-*.tar.gz`
* `cd prometheus-*`
* `./prometheus &`
* Check installation:
    * `curl localhost:9090`
    * `http://YOUS_SERVER_IP:9090/graph` (open in web browser)

### Install (Docker)
* `docker run --publish 9090:9090 --detach prom/prometheus`
* Open in web browser -  `http://YOUS_SERVER_IP:9090/graph`

### Getting started
* Install prometheus
* Check exposed metrics:
    * `http://YOUR_SERVER_IP:9090/targets`
    * `http://YOUR_SERVER_IP:9090/metrics`
* Check stored metrics:
    * `http://YOUR_SERVER_IP:9090/graph`
    * `go_gc_duration_seconds_sum` (expression)

### Alerting
* Universal method [(sends http requests)](https://prometheus.io/docs/alerting/latest/configuration/#webhook_config)
