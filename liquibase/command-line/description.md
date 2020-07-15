## Main template
* Make sure that liquibase is installed:
    * `liquibase --version`
* Go to folder with changesets
* Execute:
```
liquibase ^
    --driver=org.postgresql.Driver ^
    --classpath=C:\Programs\Liquibase\drivers\postgresql-42.2.5.jar ^
    --changeLogFile=gen_tokens.xml ^
    --url=jdbc:postgresql://178.43.67.143:5432/db-name ^
    --username=postgres ^
    --password=postgres ^
    INSERT_COMMAND_HERE
```

## Execute SQL
* Generate SQL based on changesets from `gen_tokens.xml` and save to file `script.sql`:
    * replace `INSERT_COMMAND_HERE` with `updateSQL > script.sql`
* To actually execute SQL:
    * replace `INSERT_COMMAND_HERE` with `update`

## Tag => Execute SQL => Rollback to tag
* replace `INSERT_COMMAND_HERE` with `tag TEST_CHANGESET_ROLLBACK`
* replace `INSERT_COMMAND_HERE` with `update`
* replace `INSERT_COMMAND_HERE` with `rollback TEST_CHANGESET_ROLLBACK`

## Rollback 5 last changesets
* replace `INSERT_COMMAND_HERE` with `rollbackCountSQL 5 > rollback.sql`
    * check generated SQL
* replace `INSERT_COMMAND_HERE` with `rollbackCount 5`

## Liquibase tables
* Show changesets history:
    * `select * from DATABASECHANGELOG`
* See if liquibase is running right now:
    * `select * from DATABASECHANGELOGLOCK`
