### Prometheus + AlertManager + PushGateway
* TLDR - Prometheus stores metrics; AlertManager sends alerts; PushGateway - receives pushed metrics
* Run - `docker-compose up`
* Check:
    * Prometheus - http://localhost:9090/graph
    * AlertManager - http://localhost:9093/api/v2/status
    * PushGateway - http://localhost:9091/metrics
