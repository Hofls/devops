* [Liquibase Change Types](https://docs.liquibase.com/change-types/home.html)
    * E.g. - addColumn, dropIndex, createTable

### Errors
* `Could not release lock` with `Connection is closed`
    * Means liquibase migration threw error (e.g. when you try to delete row, which is part of foreign key constraint)
    * Identify problem:
        * Find changeset with problem (changeset after last one in the list)
            * `select * from databasechangelog order by dateexecuted desc`
        * Try to execute changeset manually (should show error)
    * Fix problem and run migrations again
