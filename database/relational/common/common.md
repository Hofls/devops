### Architecture patterns
* One DB, many microservice replicas
    * Replicas read and write into same DB
    * Replicas dynamically created and destroyed, based on load (usually in k8s)
* One main DB, one DB replica (on standby), multiple microservice replicas
    * If main DB fails, standby DB takes it place
* One main DB, multiple DB replicas, multiple microservice replicas
    * `CQRS` - Insert into main DB, read from replica DB (via load balancer)
* `Sharding` - distributes data across different databases (each DB has only subset of data)
    * If no space left - just add another shard (server), all new data will be stored there
* `Federation` - splits database by domain (one db for users, another db for products)

### High level (abstract)
* `Relational` - data stored in tables (with rows and columns), has ACID transactions, in CAP choses CP
    * Use cases:
        * Relational data (e.g. person.id, workplace.person_id, passenger.person_id, seller.person_id)
* `Standby` - total replica of main DB. If main DB dies - just start using standby
* `Replication` - process of copying data from one database to another 
    * Increases availability and scalability (if one DB dies, switch to another one)
* `Denormalization` - redundant copies of data written in different tables to avoid expensive joins
    * Better read performance, worse write performance
* `ACID` - properties of database transactions
    * `Atomicity` - transaction is either succeeds completely, or fails completely
    * `Consistency` - transaction can only bring the database from one valid state to another (constraints are satisfied)
    * `Isolation` - concurrent execution of transactions leaves the database in the same state that would have been obtained if the transactions were executed sequentially
    * `Durability` - once a transaction has been committed, it will remain committed even in the case of a system failure
    
### Low level (details)
* `Decision influencing factors`
    * Simplicity, Performance, Ease of writing/reading SQL queries
* `Primary key` - person.id
* `Foreign Key` - person.university_id
* `Names` should be singular, lowercase, snake case
    * user, extra_coupon
* `Identifier column name` = table name + id
    * customer_id, event_id, shop_id
* `Index` = column names + index
    * `shop_purchase_product_index`
* `Directory table` (id, directory, value, value_description)
    * (1, 'CancelReason', 'TOO_LATE', '7 days passed after purchase')
* `Distributed DB`:
    * `Horizontal partitioning` - different rows in different tables (e.g. customers_europe, customers_africa)
    * `Vertical partitioning` - different columns in different tables (e.g. infrequently used data, very wide columns)
* `Connections`
    * 1 connection = 1 operation at the same time
    * Connections are expensive to create. Solution - `connection pool`. Create n connections once, use them forever
    * [Connections formula](https://stackoverflow.com/questions/28987540/why-does-hikaricp-recommend-fixed-size-pool-for-better-performance)
        * For most servers optimum is 10-20
* `Cache`
    * Makes sense only if app has fixed amount of query plans (different parameters = different plan)
    * `Query plan` cache
    * `Prepared statement` cache
* `Locking`:
    * `Optimistic Locking` - two people edit article, first saves, second gets error/notification
        * Used when collisions are rare
        * Implementation: store last change time for each record, compare them on save
    * `Optimistic Locking (SQL)`:
        * `update ... where version = 1` if no such record - throws error
        * Means only 1 of multiple parallel queries would succeed
    * `Pessimistic Locking` - first person edits article, second is unable to (article is locked)
        * Use if you expect a lot of collisions
    * `Pessimistic Locking (SQL)`:
        * `select ... for update` blocks specific record
        * 1 locks, other parallel queries just wait (update, select for update)
* `Locking queries vs Non locking queries`
    * Locking queries. If bunch of users work with the table, don't run those:
        * Field update for 5k+ rows. If you must - better use batching (e.g. 1k rows per transaction)
    * Non locking queries. Safe to run any time:
        * New field, new index (with `CONCURRENTLY`), view update
* It's ok to create indexes on DB even during high load, just add `CONCURRENTLY` (Postgres):
    * CREATE INDEX CONCURRENTLY idx_guest_address_id ON public.guest USING btree (address_id);
* `Cascade`
    * Delete main row + all related rows from other tables (linked by foreign key)