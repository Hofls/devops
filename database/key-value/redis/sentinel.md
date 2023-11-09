### Info
* `Redis Sentinel` - redis with high availability (distributed)
    * Monitors redis instances, sends notifications, automatic failover (if master fails - promotes replica to new master)
    
### Getting started (on server)
* Install docker:
    * `apt update && apt install docker.io`
* Launch redis instance:
    ```
    docker run -d --name redis-server \
        -p 6379:6379 \
        -e ALLOW_EMPTY_PASSWORD=yes \
        --network app-tier \
        bitnami/redis:latest
    ```
* Launch sentinel instance:
    ```
    docker run -d -it --rm \
        -p 26379:26379 \
        -e REDIS_MASTER_HOST=redis-server \
        --network app-tier \
        bitnami/redis-sentinel:latest
    ```
* Check sentinel instance:
    * SSH into sentinel - `docker exec -it f45127613ba6 bash`
    * Redis-cli into sentinel - `redis-cli -p 26379`
    * List monitored masters - `SENTINEL masters` (should have IP address and runid)
* Connect from local PC to remote sentinel:
    * `redis-cli -h 153.26.144.76 -p 26379` (if needed password - `-a 'qwertyB'`)

### Docker compose (locally)
* Start `docker-compose up -d` in [directory](sentinel)
* Stop - `docker-compose down`
