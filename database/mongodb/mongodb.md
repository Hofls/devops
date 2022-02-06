#### Info
* MongoDB - NoSQL database (for json documents)

#### Getting started. CLI
* `docker pull mongo`
* `docker run --name some-mongo -d mongo`
* `docker exec -it some-mongo bash`
* `mongo`
	* `help`
	* `db.products.insert( { _id: 10, item: "box", qty: 20 } )`
	* `db.products.find( {item: "box"} )`

#### Getting started. GUI
* `docker pull mongo`
* `docker run --name some-mongo -p 27017:27017 -d mongo`
* `curl localhost:27017`
    * It looks like you are trying to access MongoDB over HTTP on the native driver port.
* TODO