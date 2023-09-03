* Change max connections count:
    * `SHOW max_connections;`
    * `ALTER SYSTEM SET max_connections TO '100';`
    * Restart PostgreSQL
* Change user password (on Windows) 
    * `D:\Programs\PostgreSQL\bin\psql.exe -U postgres`
    * `ALTER USER hofls WITH PASSWORD '123456'`
* Dump:
    * Create [db for tests](test_db.sql)
    * In source PostgreSQL, 
        * Log in as `posgres` user - `sudo -u postgres -i`
        * Dump data `pg_dump customers_db > customers_dump.sql`
    * In target PostgreSQL:
        * Manually create database `customers_db`
        * Pick 1:
            * Via console - `psql -U postgres customers_db < dump.sql`
            * Via DBeaver - `customers_db` -> right click -> `Tools` -> `Execute script` -> set path to `customers_dump.sql`
