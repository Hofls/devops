#### Info
* PostgreSQL - relational database

#### Getting started. GUI
* Run PostgreSQL on server:
    * `docker run -p 5432:5432 -e POSTGRES_PASSWORD=postgres -d postgres`
* Run DBeaver on client:
    * New Database Connection -> PostgreSQL
        * Host: YOUR_SERVER_IP
        * Password: postgres
    * Test Connection -> Finish