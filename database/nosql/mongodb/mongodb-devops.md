#### Info
* MongoDB - NoSQL database (for json documents)

#### Getting started. CLI
* `docker run --name some-mongo -p 27017:27017 -d mongo`
* `curl localhost:27017` and `http://YOUR_SERVER_IP:27017`
    * It looks like you are trying to access MongoDB over HTTP on the native driver port.
* `docker exec -it some-mongo bash`
* `mongo`
	* `help`
	* `db.products.insert( { _id: 10, item: "box", qty: 20 } )`
	* `db.products.find( {item: "box"} )`

#### Getting started. GUI
* Prerequisite: MongoDB installed on server, accessible via `http://YOUR_SERVER_IP:27017`
* Install and run [MongoDB Compass](https://www.mongodb.com/try/download/compass)
* `New connection` -> `mongodb://YOUR_SERVER_IP:27017/` -> `Create Database/Collection` -> `Add data` -> `{"hello": "world"}`
* Features:
    * Performance monitoring (operations, network, memory)
    * Documents - CRUD
    * Aggregations - count, sort, group, limit..
    * Schema, Explain Plan, Indexes, Validation rules
