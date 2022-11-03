#### Info
* Grafana - web app for data visualization

#### Getting started

#### Queries
* Use time range from dashboard UI in query:
     * `SELECT * FROM "auth_server/status" WHERE $timeFilter`
* Use variable value from dashboard UI in query:
    * `SELECT * FROM "auth_server/status" WHERE name IN ($server_name) OR $server_name IS NULL`
* 
