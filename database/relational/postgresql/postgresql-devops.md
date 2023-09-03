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
* Launch psql console - `sudo -u postgres psql`
* List databases - `SELECT datname FROM pg_database;`
* Connect to db named "shop_db" - `\c shop_db`
* List tables - `\dt`
* Look at rows in a table  - `select * from customer limit 10;`
