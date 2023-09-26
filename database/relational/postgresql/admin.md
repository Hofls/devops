#### Info
* PostgreSQL - relational database
* Persistence: `--volume /opt/postgressql:/var/lib/postgresql/data`
* Set max_connections to 100: `docker run postgres -N 100`

#### Getting started. GUI
* Run PostgreSQL on server:
    * `docker run -p 5432:5432 -e POSTGRES_PASSWORD=postgres -d postgres`
* Run DBeaver on client:
    * New Database Connection -> PostgreSQL
        * Host: YOUR_SERVER_IP
        * Username: postgres
        * Password: postgres
    * Test Connection -> Finish

#### Getting started. CLI
* TODO - run PosgreSQL on server
* Launch psql console - `psql` or `sudo -u postgres psql`
    * Move to `/opt` if error appears - `could not change directory to "/home/hofls": Permission denied` 
* List databases - `SELECT datname FROM pg_database;`
* Connect to db named "shop_db" - `\c shop_db`
* List tables - `\dt`
* Look at rows in a table  - `select * from customer limit 10;`

#### Commands
* Change max connections count:
    * `SHOW max_connections;`
    * `ALTER SYSTEM SET max_connections TO '100';`
    * Restart PostgreSQL
* Change user password (on Windows) 
    * `D:\Programs\PostgreSQL\bin\psql.exe -U postgres`
    * `ALTER USER hofls WITH PASSWORD '123456'`
* Dump:
    * Create [db for tests](test_db.sql)
    * In source PostgreSQL, pick 1:
        * A:
            * `pg_dump -U postgres -F t customers_db > customers_dump.tar`
        * B:
            * Log in as `postgres` user - `sudo -u postgres -i`
            * Dump data `pg_dump customers_db > customers_dump.sql`
    * In target PostgreSQL:
        * Manually create database `customers_db`
        * Pick 1:
            * Via console - `psql -U postgres customers_db < dump.sql`
            * Via DBeaver - `customers_db` -> right click -> `Tools` -> `Execute script` -> set path to `customers_dump.sql`
