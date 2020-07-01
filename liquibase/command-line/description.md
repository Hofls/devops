## Main template
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

## Liquibase tables
* Show changesets history:
    * `select * from DATABASECHANGELOG`
* See if liquibase is running right now:
    * `select * from DATABASECHANGELOGLOCK`