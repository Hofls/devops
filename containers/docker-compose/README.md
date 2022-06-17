# docker-compose-example
* Simple example of docker-compose usage (MySQL + Wordpress + nginx)
* Notice: usability of docker-compose is very limited (e.g. only good for running environment on dev PC)

## Docker-compose. Ubuntu
#### Install docker and docker-compose:
* `apt-get update`
* `apt install docker.io`
    * to test installation:
        * `docker pull hello-world`
        * `docker run hello-world`
* `apt install docker-compose`
#### Configure and run:
* Transfer files from local `resources` folder to the server
* Run containers (from the same folder where you put docker-compose.yml)
    * `docker-compose up --build -d`
* Check that everything is working:
    * `docker ps`
    * `wget localhost:8080`
    
#### Extra:
* If you want to give everybody access to Wordpress:
    * Set up a [reverse proxy](https://github.com/Hofls/nginx-config-example)
    * Add following lines in `/opt/wordpress-persist/wp-config.php`:
        * define( 'WP_HOME', 'http://YOUR_SITE_IP_ADDRESS/wordpress/' );
        * define( 'WP_SITEURL', 'http://YOUR_SITE_IP_ADDRESS/wordpress/' );
    * Open URLs in browser: 
        * http://YOUR_SITE_IP_ADDRESS/wordpress/
        * http://YOUR_SITE_IP_ADDRESS/wordpress/wp-login.php
* To stop all the containers - `docker-compose down`
