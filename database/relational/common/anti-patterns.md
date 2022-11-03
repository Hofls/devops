* `Inconsistency`
    * e.g. - one table named "event" another - "T_USERS"
* `Multiple values in one cell`
    * e.g. - "James Bond, 007"
* `Recursive Dependency`
    * Better use closure table / path enumeration / nested sets
* `Primary key does not exist`
    * Without it you can't reference individual row
* `Entity-Attribute-Value Model` (store different objects with different fields)
    * Just store json in DB
* `Imprecise Data Type` (FLOAT, REAL, or DOUBLE PRECISION)
    * Better use precise types - NUMERIC or DECIMAL
* `Store files in DB`
    * Sometimes it's OK, depends on size and amount of files
* `Unused indexes`
    * Look at "Table index usage" in useful-queries.md
* `Concatenation` to build SQL query
    * Vulnerable to SQL injection
* `Database as message queue`
    * Use specialized products
* `Plain text password storage`
* `Everything in one table (god table)`
    * Hard to work with
* `Everything in different tables`
    * Joins are expensive
* `UUID as primary key`
* `Unnecessary cache`
    * If most queries are unique - cache makes no sense.
    * In this case cache ignored, but still takes time to maintain
* `No foreign key`
    * Hard to discover relations, no guarantee that id actually exists
