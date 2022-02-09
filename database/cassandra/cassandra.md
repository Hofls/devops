#### Info
* Cassandra - wide-column store
* Use cases: big data, real-time analytics/reports
* Characteristics:
    * Writes fast, but reads/updates slow
    * No ACID, no aggregates, no joins

#### Getting started. CLI
* `docker run --name cass_cluster --detach cassandra:4.0`
* `docker exec -it cass_cluster bash`
    * `cqlsh`
    * `DESCRIBE keyspaces;`
    * `USE system;`
    * `DESCRIBE tables;`
    * `SELECT * FROM size_estimates;`

#### Getting started. GUI
* Good client not found
