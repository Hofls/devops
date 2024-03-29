##### Generic
* Execution plan is main metric, less cost means better performance (`EXPLAIN` / `ANALYZE`)
* First priority - minimize an amount of rows by applying filters
    * Only after that use functions, aggregates, etc
* Second priority - make sure subqueries execute only once
    * Subquery - `with subquery as (select * from ...)`
    * Bad usage - `select * from subquery`, will execute subquery for each row
    * Good usage - `inner join subquery`, will execute subquery only once (something like cache)
* Try to avoid using functions/type conversions (especially in `WHERE`/`JOIN`)
    * If you have 1 million rows, function will be called on every one of them
* Pick specific columns, don't use `*`
* Use `UNION ALL` instead of `UNION` (`UNION` wastes resources to remove duplicates)
* Use pagination if possible
* Use connection pool to avoid constantly creating new connections (it's expensive)
    * e.g. HikariCP (best used as fixed-size connection pool)
    
#### Indexes
* Replace `Sequential scan` with `Index scan` by adding indexes
    * `B-tree` is default index. Works for specific value search, range scanning and sorting
    * `CREATE INDEX idx_address_city on address(city)`
* `Hash` index for equality operators, e.g. `WHERE city = 'Paris'`
    * `CREATE INDEX idx_address_city on address using HASH(city)`;
* `GIN` index for composite types (JSONB, Array, Range, full-text search)
    * Standard indexes only work with this: `name like 'Benjami%'`
    * `gin_trgm_ops` can work with this: `name like '%enjamin%'` (look at [text-search.md](text-search.md))
* `BRIN` index for summary (min/max), e.g. `SELECT MAX(temperature) FROM sensor WHERE timestamp > '2020-03-17' and timestamp < '2020-03-26'`
    * `CREATE INDEX salary_idx ON sensor USING BRIN(timestamp)`
* Index for multiple columns, e.g. `WHERE city = 'Paris' and street = 'Olamore'`
    * `CREATE INDEX user_city_street_idx ON address (city, street);`
* Index for partial search, e.g. `name like 'Joh%'` is `varchar_pattern_ops`
* Index for function, e.g. `WHERE lower(email) = "qq@mail.com`
   * `CREATE INDEX user_email_idx ON user(lower(email));`)

##### Query execution plan is slow / Index not working 
* `name like '%enjamin%'`
    * Look for `gin_trgm_ops` at [text-search.md](text-search.md)
* `OR clause`
    * Problem:
        * Scans all rows in both tables - `where visit.customer_id = 23 or passive.customer_id = 23`
    * Fix:
        ```
        visit_with_passive (
            select * from visit 
            where visit.customer_id = 23
            union
            select visit.* from passive 
            join visit on passive.id = visit.passive_id
            where passive.customer_id = 23
        )
        ```
* `CASE, WHEN, ELSE, END`
    * Problem:
        * `WHEN :branchId IS NOT NULL THEN visit.spec_id = 23 ELSE passive.spec_id = 47 END`
    * Fix:
        ```
        visit_with_passive (
            select * from visit 
            where :branchId IS NOT NULL and visit.spec_id = 23
            union
            select visit.* from passive 
            join visit on passive.id = visit.passive_id
            where :branchId IS NULL and passive.spec_id = 47
        )
        ```
* `Function call`
    * Problem:
        * UNNEST executes for each row in jump table - `jump.id IN (SELECT * FROM UNNEST(parameters.ids))`
    * Fix:
        ```
        jumps_unnested AS (
            SELECT UNNEST(parameters.jumpIds) AS ids
            FROM parameters
        ) 
        select * from jumps
        where jump.id IN (SELECT * FROM jumps_unnested)
        ```
* `Most of the values are the same`
    * Problem:
        * Index on status, but query is slow - `SELECT * FROM document WHERE status = 'DONE'`
    * Explanation:
        * Index won't work, because 80% of rows have status = DONE
        * Index will work only for rare statuses (e.g. DELETED, PENDING)
* `Count of rows in a table (COUNT)`
    * Problem:
        * Table is huge, COUNT is too slow
    * Fix:
        * Use approximate count:
        ```
        SELECT reltuples AS estimate FROM pg_class where relname = 'user';
        ```
* `order by + limit is very slow` 
    * Problem:
        * Query with `order by` is very fast, but comes down to a halt if you add `limit`
        * `order by value asc limit 10`
    * Explanation:
        * Often happens when you query complex view (instead of table), look at `view is slow`
        * Most likely optimizer got confused and did poor job with creating query plan
    * Fix:
        * Help optimizer by separating `order by` and `limit`:
        ```
        with result as (
            // insert query with "order by" here
        ) select * from result limit 10
        ```
* `View is slow`
    * Problem:
        * Each time you query `view` - you execute underlying queries (view doesnt store any data itself)
    * Fix:
        * If data doesnt change very often - replace `view` with `materialized view`
        * Refresh materialized via via trigger (on source data change)