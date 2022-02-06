#### Info
* MongoDB - NoSQL database (for json documents)

#### Getting started
* `docker pull mongo`
* `docker run --name some-mongo -d mongo`
* `docker exec -it some-mongo bash`
* `mongo`
	* `help`
	* `db.products.insert( { _id: 10, item: "box", qty: 20 } )`
	* `db.products.find( {item: "box"} )`
