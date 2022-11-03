#### Info
* Flyway - version control for database
* Warning! 
    * No way to automatically generate rollback script
    * No way to rollback migrations at all (in free version)
* Info about migrations stored in table `flyway_schema_history`

#### Getting started
* [Prerequisites](../database/relational/postgresql/devops.md)
* Install flyway:
    * `wget https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/8.5.4/flyway-commandline-8.5.4-linux-x64.tar.gz`
    * `tar -xvf flyway-commandline-8.5.4-linux-x64.tar.gz`
    * `ln -s /opt/flyway-8.5.4/flyway /usr/local/bin`
    * `flyway -v`
* Configure:
    * `nano /opt/flyway-8.5.4/conf/flyway.conf`
        ```
        flyway.url=jdbc:postgresql://localhost:5432/postgres
        flyway.user=postgres
        flyway.password=postgres
        ```
* Create migration:
    * `cd /opt/flyway-8.5.4/sql`
    * `touch V1__Create_person_table.sql`
    * `nano V1__Create_person_table.sql`
        ```
        create table PERSON (
            ID int not null,
            NAME varchar(100) not null
        );
        ```
* Run flyway:
    * `cd /opt/flyway-8.5.4`
    * `flywate migrate`
    * `flyway info`

#### Commands
* `flyway migrate` - apply all new migrations
* `flyway info` - details and status about migrations 
* `flyway validate` - diff between migrations applied to the database and local ones
* `flyway undo` - undoes most recent migration (not available in community edition)
