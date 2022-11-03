#### Info
* TiDB - newSQL database

#### Getting started
* Install:
    * `curl --proto '=https' --tlsv1.2 -sSf https://tiup-mirrors.pingcap.com/install.sh | sh`
    * Reopen terminal
* Run server - `tiup playground`
    * To view the dashboard: http://127.0.0.1:2379/dashboard
    * PD client endpoints: 127.0.0.1:2379
    * To view the Prometheus: http://127.0.0.1:9090
    * To view the Grafana: http://127.0.0.1:3000
* Connect with mysql:
    * `mysql --comments --host 127.0.0.1 --port 4000 -u root -p`
    * `SHOW DATABASES;`
    * `USE metrics_schema;`
    * `SHOW TABLES;`
    * `select * from uptime;`
* Connect with tiup client:
    * `tiup client`
