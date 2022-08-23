* Tracing systems help with:
    * Distributed transaction monitoring, performance and latency optimization, root cause analysis
    * Service dependency analysis, distributed context propagation
* Example:
    * Shop service sends request to Inventory and Plan services, which send requests to other services
    * Tracing system shows them all, helps to understand how system works, and where problems occur
* How it works:
    * Zipkin attaches IDs to requests (e.g. "trace ID" http header, to know which requests are related)