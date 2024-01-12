#### DB health check
* List 20 biggest tables:
```
select schemaname as table_schema,
    relname as table_name,
    pg_size_pretty(pg_total_relation_size(relid)) as total_size,
    pg_size_pretty(pg_relation_size(relid)) as data_size,
    pg_size_pretty(pg_total_relation_size(relid) - pg_relation_size(relid))
      as external_size
from pg_catalog.pg_statio_user_tables
order by pg_total_relation_size(relid) desc,
         pg_relation_size(relid) desc
limit 20;
```
* Running queries:
```
SELECT pid, state, age(clock_timestamp(), query_start), usename, query
FROM pg_stat_activity 
where state <> 'idle'
ORDER BY query_start asc;
```
* Active connections (grouped):
```
SELECT application_name, count(*) 
FROM pg_stat_activity
group by application_name
order by application_name;
```
* Slow queries:
```
-- In new version, use column mean_exec_time instead of calculating avg_time_ms
select query, calls, (total_time/calls)::integer as avg_time_ms 
from pg_stat_statements
where calls > 20 and query <> '<insufficient privilege>'
order by avg_time_ms desc
limit 400;
```
* Approximate count (if standard count is too slow)
```
SELECT reltuples AS estimate FROM pg_class where relname = 'customer';
```
* Table index usage
```
-- should be around 0.99 for all big tables:
SELECT stat.relname, 100 * idx_scan / (seq_scan + idx_scan) percent_of_times_index_used, cl.reltuples as approximate_count
FROM pg_stat_user_tables stat
inner join pg_class cl on cl.relname = stat.relname
WHERE (seq_scan + idx_scan) <> 0
ORDER BY approximate_count DESC;
```
* Unused indexes:
```
SELECT relname AS table_name, indexrelname AS index_name, idx_scan, idx_tup_read, idx_tup_fetch, pg_size_pretty(pg_relation_size(indexrelname::regclass))
FROM pg_stat_all_indexes
WHERE schemaname = 'public'
AND idx_scan = 0
AND idx_tup_read = 0
AND idx_tup_fetch = 0
ORDER BY pg_relation_size(indexrelname::regclass) DESC;
```
* Missing indexes:
```
SELECT
  relname,
  seq_scan - idx_scan AS too_much_seq,
  CASE
    WHEN
      seq_scan - coalesce(idx_scan, 0) > 0
    THEN
      'Missing Index?'
    ELSE
      'OK'
  END,
  pg_relation_size(relname::regclass) AS rel_size, seq_scan, idx_scan
FROM
  pg_stat_all_tables
WHERE
  schemaname = 'public'
  AND pg_relation_size(relname::regclass) > 80000
ORDER BY
  too_much_seq DESC;
```

#### Etc
* Show everything that references table:
```
select 
  (select r.relname from pg_class r where r.oid = c.conrelid) as table, 
  (select array_agg(attname) from pg_attribute 
   where attrelid = c.conrelid and ARRAY[attnum] <@ c.conkey) as col, 
  (select r.relname from pg_class r where r.oid = c.confrelid) as ftable 
from pg_constraint c 
where c.confrelid = (select oid from pg_class where relname = 'INSERT_TABLE_NAME_HERE');
```
* List everything table refers to:
```
select 
  (select r.relname from pg_class r where r.oid = c.conrelid) as table, 
  (select array_agg(attname) from pg_attribute 
   where attrelid = c.conrelid and ARRAY[attnum] <@ c.conkey) as col, 
  (select r.relname from pg_class r where r.oid = c.confrelid) as ftable 
from pg_constraint c 
where c.conrelid = (select oid from pg_class where relname = 'INSERT_TABLE_NAME_HERE');
```
* Kill query:
```
-- running:
SELECT pg_cancel_backend(pid);
-- idle:
SELECT pg_terminate_backend(pid);
```
* All users:
```
SELECT * FROM pg_user;
```
* Settings:
```
SELECT * FROM pg_settings;
```
* Locks held by open transactions:
```
SELECT count(distinct pid) FROM pg_locks WHERE granted = false;
```
