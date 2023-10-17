### Info
* `Redis Sentinel` - redis with high availability (distributed)
    * Monitors redis instances, sends notifications, automatic failover (if master fails - promotes replica to new master)
    
### Getting started
* Install docker:
    * `apt update && apt install docker.io`
* Launch redis instance:
    ```
    docker run -d --name redis-server \
        -e ALLOW_EMPTY_PASSWORD=yes \
        --network app-tier \
        bitnami/redis:latest
    ```
* Launch sentinel instance:
    ```
    docker run -d -it --rm \
        -e REDIS_MASTER_HOST=redis-server \
        --network app-tier \
        bitnami/redis-sentinel:latest
    ```
* Check sentinel instance:
    * SSH into sentinel - `docker exec -it f45127613ba6 bash`
    * Redis-cli into sentinel - `redis-cli -p 26379`
    * List monitored masters - `SENTINEL masters` (should have IP address and runid)
