#### Info
* InfluxDB - time series database

#### Getting started
* Prerequisites: linux with installed docker
* `docker run --name influxdb --publish 8086:8086 --detach influxdb:2.1.1`
* Open `http://YOUR_SERVER_IP:8086/`, register new account
* Features:
    * Telegraf - server agent that collects metrics and sends them to InfluxDB (push model)
    * Scrapers - periodically sends http request to URL, to get data in prometheus format (pull model)
    * Dashboards, Alerts, Tasks (cron)
