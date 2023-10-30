#### Info
* Grafana - web app for data visualization

#### Getting started
* `docker run --detach --publish 3000:3000 grafana/grafana`
* Open in browser - `http://YOUR_SERVER_IP:3000`
    * Credentials - admin/admin

#### Queries
* Use time range from dashboard UI in query:
     * `SELECT * FROM "auth_server/status" WHERE $timeFilter`
* Use variable value from dashboard UI in query:
    * `SELECT * FROM "auth_server/status" WHERE name IN ($server_name) OR $server_name IS NULL`
