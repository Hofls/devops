#### Info
* [Main article](/database/key-value/redis/redis.md)

#### Getting started. CLI
* `docker run --name some-redis -p 6379:6379 --detach redis:6.2.6`
* `docker exec -it some-redis bash`
    * `redis-cli`
    * `SUBSCRIBE purchase` (from first console)
    * `PUBLISH purchase "{item: 54838, price: 23.50}"` (from second console)
    * First console should display message
