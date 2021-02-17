## Common
##### Run from command line
* `gatling.bat -s RecordedSimulation`

## Scala code
##### Modify generated code
* Isolate processes
    * `scenario("Scenario Name").exec(Create.create, Search.search, Edit.edit)`
* Use feeders (data sources with different values)
    * If every test will use the same values - it may be cached on server side
* Avoid duplication

##### Run 20 tests in parallel
* Replace `atOnceUsers(1)` with `atOnceUsers(20)` 
    * Alternatives: `rampUsers(), constantUsersPerSec()`

##### Debug
* Print all session values:
```
.exec { session =>
 println(session)
 session
}
```
