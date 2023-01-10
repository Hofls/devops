* Change max connections count:
    * `SHOW max_connections;`
    * `ALTER SYSTEM SET max_connections TO '100';`
    * Restart PostgreSQL
* Change user password (on Windows) 
    * `D:\Programs\PostgreSQL\bin\psql.exe -U postgres`
    * `ALTER USER hofls WITH PASSWORD '123456'`
* Dump (TODO - make sure that it's working):
    * In source PostgreSQL:
        * `pg_dump -U postgres customers_db > dump.sql`
    * In target PostgreSQL:
        * Manually create database `customers_db`
        * `psql -U postgres customers_db < dump.sql`
