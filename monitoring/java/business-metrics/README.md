* Execute`mvn clean spring-boot:run`
* Open:
    * http://localhost:8080/findProduct
    * http://localhost:8080/business-metrics
* Result will look something like this:
```
# HELP liveTest_findProduct_all_total  
# TYPE liveTest_findProduct_all_total counter
liveTest_findProduct_all_total 14.0
# HELP liveTest_findProduct_failure_total  
# TYPE liveTest_findProduct_failure_total counter
liveTest_findProduct_failure_total 5.0
```
