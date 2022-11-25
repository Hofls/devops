#### Info
* RabbitMQ - message broker

#### Getting started. CLI
* `docker run --name some-rabbit -p 5672:5672 -p 15672:15672 --detach rabbitmq:3.9`
* `docker exec -it some-rabbit bash`
    * `rabbitmqctl help`
    * `rabbitmq-diagnostics help`
    * `rabbitmq-plugins help`

#### Getting started. GUI
* Prerequisite: RabbitMQ installed on server
* `docker exec -it some-rabbit bash`
    * `rabbitmq-plugins enable rabbitmq_management`
    * `rabbitmqctl add_user hofls qwerty`
    * `rabbitmqctl set_user_tags hofls administrator`
* Open in browser `http://YOUR_SERVER_IP:15672`
* Features:
    * Connections, Channels, Exchanges, Queues, Admin
