#### Info
* Stores logs, provides web UI with search/dashboards/alerting/analytics
* Graylog uses: Elasticsearch, MongoDB, Java
* Scaling resources: CPU for Graylog. Ram and Disk for Elasticsearch

#### Search syntax
* Strict search - `"Hello world"`
* Regex search - `"/Hell+/"`
* Both - `"Hello" && "world"`
* At least one - `"Hello" || "world"`
* Only hello - `"Hello" && NOT "world"`
* Search by graylog parameters:
    * Find specific server - `server_name: "maskd-prp-2"`
    * Find any server, except this one - `-server_name: "maskd-prp-2"`

#### Configuration
* Create a user to view logs:
    * `System` -> `Users and Teams` -> `Create User`
    * `Username` - `graylog`
    * `Password` - `graylog`
    * `Assign Roles` - `View Manager`
    * Fill in the rest of the required fields with random data
* Add privileges to view messages:
    * `Streams` -> `All messages` -> `Share`
    * Select user -> `Add Collaborator` -> `Save`
* Create an input with type Beats:
    * `System` -> `Inputs` -> `Select input` -> `Beats` -> `Launch new input`
    * `Title` - `Beats input`
* Add restrictions on index size:
    * `System` -> `Indices` -> `Default index set` -> `Edit`
    * `Select rotation strategy` - `Index Size`
    * `Max size per index` - `400MiB`
    * `Max number of indices` - `2`

#### Getting started
* Run MongoDB:
    ```
    docker run --name mongo -d mongo:4.2
    ```
* Run Elasticsearch:
    ```
    docker run \
    --name elasticsearch \
    -e "http.host=0.0.0.0" \
    -e "discovery.type=single-node" \
    -e "ES_JAVA_OPTS=-Xms512m -Xmx512m" \
    -d docker.elastic.co/elasticsearch/elasticsearch-oss:7.10.2
    ```
* Run Graylog:
    ```
    docker run --name graylog --link mongo --link elasticsearch \
    -p 9000:9000 -p 12201:12201 -p 1514:1514 -p 5555:5555 \
    -e GRAYLOG_PASSWORD_SECRET=somepasswordpepper \
    -e GRAYLOG_ROOT_PASSWORD_SHA2=8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918 \
    -e GRAYLOG_HTTP_EXTERNAL_URI="http://127.0.0.1:9000/" \
    -d graylog/graylog:4.2
    ```
* Make sure everything is working:
    * `docker ps`
    * Open `http://YOUR_SERVER_URL:9000` in a web browser
        * Login/Password: admin/admin
* Send first log message:
    * Open `http://YOUR_SERVER_URL:9000/system/inputs`
    * Input `Raw/Plaintext TCP` -> Launch new input -> Global -> Save
    * `echo 'First log message' | nc localhost 5555`
    * "First log message" should appear in logs
* Configure limits:
    * `System / Indices` -> `Indices` -> `Edit`
    * Index Rotation Configuration:
        * `Rotation strategy` - `Index Size`
        * `Max size per index` -> `2GiB`
    * Index Retention Configuration:
        * `Retention strategy` - `Delete index`
        * `Max number of indices` - `2`