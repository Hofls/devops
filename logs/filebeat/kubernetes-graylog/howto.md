### Kubernetes + Graylog + Filebeat
* Kubernetes:
    * Add [filebeat-config.yaml](filebeat-config.yaml)
    * Update [kube-deployment.yaml](kube-deployment.yaml)
    * Add line to deploy script (e.g. `.gitlab-ci.yml`):
        * `kubectl apply -f extras/filebeat-config.yaml --validate=false`
* Graylog:
    * Log in as admin
    * `http://GRAYLOG_URL/streams` -> `Create Stream`
    * `Manage Rules` -> `Add stream rule`
        * `Field` - `app_name`
        * `Value` - `cook`
    * `Share` -> `Add Collaborator` -> `Save`
    * `Start Stream`
