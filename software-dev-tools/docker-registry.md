#### Info
* `Docker registry` - docker image storage

#### Getting started
* Install & run:
    * `docker run -d -p 5000:5000 registry:2`
* Check it:
    * `docker pull ubuntu`
    * `docker tag ubuntu localhost:5000/ubuntu`
    * `docker push localhost:5000/ubuntu`
