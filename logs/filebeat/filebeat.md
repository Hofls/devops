#### Info
* `Filebeat` - agent that gathers logs and sends them to store/processing system (e.g. `Elasticsearch`)

#### Getting started
* Install `Filebeat`:
  ```
  curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.11.0-linux-x86_64.tar.gz
  tar xzvf filebeat-7.11.0-linux-x86_64.tar.gz
  ```
  * Make sure connection to `Elasticsearch` is working:
    * `telnet 84.123.154.23 9200`
  
* Edit `filebeat.yml`:
  * Configure connect to `Elasticsearch`:
    ```
    output.elasticsearch:
    hosts: ["84.123.154.23:9200"]
    username: "filebeat_test"
    password: "qwerty" 
    ```
  * Enable logs gathering: `- type: log`
    * Default is `/var/log/*.log`
  
* Run:
  * `nohup ./filebeat -e &`
  
* Test:
  * Create file in `/var/log/test.log`, write text `Hello world!`
  * Check filebeat logs, check `Elasticsearch`
  
#### Advanced
* To gather logs from specific application - pick a module:
  * `./filebeat modules list`
  