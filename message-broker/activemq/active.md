#### Getting started. GUI
* `docker run --publish 61616:61616 --publish 8161:8161 --detach rmohr/activemq:5.15.9`
* Open in browser `http://YOUR_SERVER_IP:8161/admin`
    * Warning! Web UI has basic auth (modern browsers cant really handle it, use incognito mode)
    * Credentials - admin/admin
* Features:
    * Queues, Topics, Subscribers, Connections, Network, Send message
    
#### Info
* Topic - each consumer receives a copy of a message (publish/subscribe)
* Queue - only one consumer receives a message (load balancer semantics)