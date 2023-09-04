# DB migration from 2.6.0 to 4.2.0
# Disclaimer - this approach is abandoned. DB structure is too different, scripts for data migration will take a lot of time

### How data migration algorithm was created [INFO]
* Download [H2 DB 2.0.202](https://www.h2database.com/html/download-archive.html) on your PC
    * Right version is very important, 2.2.222 won't even open DB files
* Download DB files from new and old wso2:
    * `/opt/wso2am-2.6.0/repository/database`
    * `/opt/wso2am-4.2.0/repository/database`
* Run H2 web API - `D:\Programs\H2 DB\bin\h2.bat`
    * `Driver Class:` - `org.h2.Driver`
    * `JDBC URL:` - `jdbc:h2:file:D:\dump\h2db\WSO2AM_DB`
    * `User Name:` - `wso2carbon`
    * `Password:` - `wso2carbon`
* For each DB and table:
    * If there is data in a table - add table to `pg_dump`
    * Then, if 4.2.0 has new fields - fill them in `after_dump.sql`

### Data migration
* Important! WSO 4.2.0 should be empty (to avoid rows with duplicate ids)
* TODO - remove quotes from dump, e.g. from `"name"`
* Create partial dump of `wso2am_db` in WSO 2.6.0:
    ```
    pg_dump wso2am_db --column-inserts --data-only \
    -t am_api -t am_api_default_version -t am_api_lc_event -t am_api_url_mapping \ 
    -t am_subscriber -t am_application \
    > wso2am_db_dump_v2.sql
    ```
* TODO - Load dump into WSO 4.2.0
* Execute [after_dump_wso2am_db.sql](src/after_dump_wso2am_db.sql)

# Config migration from 2.6.0 to 4.2.0
* 
* 
* 
