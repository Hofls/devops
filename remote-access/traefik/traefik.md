#### Info
* Traefik - http reverse proxy and load balancer. Specializes on microservices.

#### Getting started
* Create config:
    * `touch traefik.yml`
    * `nano traefik.yml`
        ```
        # Docker configuration backend
        providers:
            docker:
                defaultRule: "Host(`{{ trimPrefix `/` .Name }}.docker.localhost`)"
        # API and dashboard configuration
        api:
            insecure: true
        ```
* Run traefik:
    ```
    docker run -d -p 8080:8080 -p 80:80 \
    -v $PWD/traefik.yml:/etc/traefik/traefik.yml \
    -v /var/run/docker.sock:/var/run/docker.sock \
    traefik:v2.5
    ```
* Check dashboard `http://YOUR_SERVER_URL:8080/dashboard/#/`
