### Info
* `Redis Sentinel` - redis with high availability (distributed)
    * Monitors redis instances, sends notifications, automatic failover (if master fails - promotes replica to new master)
    
### Getting started
* Install docker:
    * `apt update && apt install docker.io`
* Launch redis instance:
    * `docker run -d -p 6379:6379 -e ALLOW_EMPTY_PASSWORD=yes bitnami/redis:latest`
* Launch sentinel instance:
    ```
    docker run -d -it --rm \
        --network host \
        -e REDIS_MASTER_HOST=localhost \
        -p 26379:26379 \
        bitnami/redis-sentinel:latest
    ```
* Check sentinel instance:
    * Ssh into sentinel - `docker exec -it f45127613ba6 bash`
    * Redis-cli into sentinel - `redis-cli -h localhost -p 26379`
    * List monitored masters - `SENTINEL masters`
