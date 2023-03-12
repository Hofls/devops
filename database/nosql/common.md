* `NoSQL` - stores data without tables, in CAP choses AP
    * Use cases:
        * If data is unstructured (different records have different fields)
        * If you can store data as single json document
    * Advantages: fast development time (just throw any json at it)
* `BASE` - NoSQL properties
    * `Basically available` - guarantees availability
    * `Soft state` - state may change over time, even without input
    * `Eventual consistency` - system will become consistent after some time
* `Key-Value Store` - O(1) reads, data stored in RAM or SSD, often used as cache
* `Document Store` - stores data as documents (JSON)
* `Wide Column Store` - uses tables, rows, and columns, just like a relational database
    * But names and format of the columns can vary from row to row in the same table
* `Graph Databases` - stores data as graph (with nodes and edges)
    * High performance for data models with very complex relationships (e.g. social network)
