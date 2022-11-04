#### Grafana + Prometheus
* Install using instructions in this repo - `grafana.md`, `prometheus.md`
* Grafana UI -> Configuration -> Data sources -> Add data source -> Prometheus
    * Host - `http://YOUR_SERVER_IP:9090`
    * Press `Save & Test`
* Explore:
    * Metric - `go_gc_duration_seconds`

#### Grafana + PostgreSQL
* Install using instructions in this repo - `grafana.md`, `postgresql-devops.md`
* Execute SQL queries with DBeaver:
    ```
    CREATE TABLE customer (
        id SERIAL PRIMARY KEY,
        name VARCHAR(100) NOT null,
        rank BIGINT not null,
        registered timestamp not null
    );
    INSERT INTO customer(name, rank, registered) VALUES('Sally', 3, current_timestamp - interval '7 hour');
    INSERT INTO customer(name, rank, registered) VALUES('John', 7, current_timestamp - interval '6 hour');
    ```
* Grafana UI -> Configuration -> Data sources -> Add data source -> PostgreSQL
    * Host - `YOUR_SERVER_IP:5432`
    * User - `postgres`
    * Password - `postgres`
    * TSL/SSL Mode - `disable`
    * Press `Save & Test`
* Explore:
    * Time range - `Last 12 hours`
    * From - `customer`
    * Time column - `registered` 
    * Select column - `rank`
    * `Toggle text edit mode`, should show SQL:
    ```
    SELECT registered AS "time", rank
    FROM customer WHERE $__timeFilter(registered)
    ORDER BY 1
    ```
    * Time-value graph is done. Now to replace it with single value:
    * Format as `Table`
    * Replace SELECT line with `SELECT avg(rank)`
    * Add to dashboard -> Visualizations -> Stat
* 