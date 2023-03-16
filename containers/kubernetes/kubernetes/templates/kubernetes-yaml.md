#### Getting started. Templates
* [Requests, limits  (CPU, RAM, Storage)](limits.yaml)
* [Deploy on node with specific label](node-with-label.yaml)
    * e.g. Android emulator works only with CPU virtualization
* [Domain name for a service](domain-name.yaml)
    * To access service via url - http://long-stick.k8s.someit.ru
* [Set environment variables](env-variables.yaml)
* [Simple cronJob example](cronjob.yaml)
* [Fault-tolerant cronJob](fault-tolerant-cronjob.yaml)
    * If did not succeed - tries again (up to 5 times)
* [Shared volumes](shared-volumes.yaml)
    * Shop pod writes logs to file, filebeat pod read them.
* [Disable websocket timeouts](websockets.yaml)
    * Warning! Best solution is sending ping to websocket every 50 seconds (connection will always be active, no need to configure timeouts)
    * By default - timeout appears after 1 minute of inactivity. For some apps its too little, they want hours/days
    * `nginx.ingress.kubernetes.io/configuration-snippet` is optional, try to remove it if something doesnt work
* [Postgres](postgres.yaml)
    * To access from one of the pods in k8s - `example-postgres:5432`
    * To access from outside - look at `Direct access to service` in `kubernetes.md`
* [Host aliases](host-aliases.yaml)
    * Changes DNS, alternative to edit `/etc/hosts`