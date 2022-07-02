#### Getting started. Templates
* [Requests, limits  (CPU, RAM, Storage)](limits.yaml)
* [Deploy on node with specific label](node-with-label.yaml)
    * e.g. Android emulator works only with CPU virtualization
* [Domain name for a service](domain-name.yaml)
    * To access service via url - http://long-stick.k8s.someit.ru
* [Set environment variables](env-variables.yaml)
* [CronJob example](cronjob.yaml)
* [Shared volumes](shared-volumes.yaml)
    * Shop pod writes logs to file, filebeat pod read them.