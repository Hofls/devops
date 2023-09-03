# Data migration from 2.6.0 to 4.2.0

### How migration algorithm was created [INFO]
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

### Migration
* 