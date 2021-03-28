### Info
* Riemann takes events/metrics as input, sends requests to other systems (e.g. alerts - telegram, storage - influxdb)

### Install (on Server)
##### Java
* `apt update`
* `apt install openjdk-14-jre-headless`
##### Riemann
* `cd /opt`
* `wget https://github.com/riemann/riemann/releases/download/0.3.6/riemann-0.3.6.tar.bz2`
* `tar xvfj riemann-0.3.6.tar.bz2`
* `cd riemann-0.3.6`
* `bin/riemann etc/riemann.config`
##### Ruby dashboard
* `apt-get -y install default-jre ruby-dev build-essential`
* `gem install --no-document riemann-client riemann-tools riemann-dash`
* `riemann-dash &`
* `curl 127.0.0.1:4567`
