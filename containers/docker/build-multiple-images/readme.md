### Why dont just use multi-stage to build bunch of services?
* Something like this:
    * `docker build --target shop-service`
    * `docker build --target user-service`
    * `docker build --target storage-service`
* Because to build target, you have to build all previous stages (insane amount of extra work)
* Purpose of multi-stage is to build a single image, not a whole lot of them

### Easy example
* Copy easy [folder](easy) on server (/opt/easy)
* Build all jars:
    * `cd /opt/easy/common`
    * `docker build --tag build-result-tag .`
* Shop. Copy & run jar:
    * `cd /opt/easy/shop`
    * `docker build --tag shop-tag .`
* User. Copy & run jar:
    * `cd /opt/easy/user`
    * `docker build --tag user-tag .`
* Run:
    * `docker images`
    * `docker run shop-tag`
    * `docker run user-tag`

### More realistic example
* Look at realistic [folder](realistic)
