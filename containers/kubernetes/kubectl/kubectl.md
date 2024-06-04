#### Generic commands
* List all resources
    * `kubectl api-resources`
    * [Full list](https://github.com/kubernetes/kubectl/issues/837#issuecomment-632092853)
* Works for most resources (Deployment, Pod, Service, Ingress, Secret, Job..)
    * `kubectl get` - list resources
        * `kubectl get pods`
        * `kubectl get all`
    * `kubectl get` - resource info
        * `kubectl get pods/spec-7664ff995c -o yaml` - source! 
    * `kubectl describe` - resource info
        * `kubectl describe nodes/minikube`
        * `kubectl describe pods/subv-fz9sd`
    * `kubectl delete` - remove resource
        * `kubectl delete pods/fileman-38dj372j2h`
    * `kubectl delete --grace-period=0 --force` - remove stuck resource (e.g. endless terminating)
        * `kubectl delete pods/fileman-38dj372j2h --grace-period=0 --force`

#### Common
* Print all events (logs)
    * `kubectl get events`
* Execute command `get pods` with [example.conf](extras/example.conf) configuration
    * `kubectl --kubeconfig=example.conf get pods`
* Show config
    * `kubectl config view`
* Watch logs LIVE
    * `kubectl logs submod-7f9fdd6f87 --tail=100 --follow`

#### Cluster
* Cluster info
    * `kubectl cluster-info`

#### Nodes
* Get nodes metrics (RAM, CPU):
    * `kubectl top nodes`

#### Pods
* Print logs for pod `submod-7f9fdd6f87`
    * `kubectl logs submod-7f9fdd6f87`
    * `kubectl logs submod-7f9fdd6f87 --previous`
* Shell (ssh) into pod `spec-7664ff995c`
    * `kubectl exec -it spec-7664ff995c -- bash`
    * `kubectl exec -it spec-7664ff995c -- /bin/sh`
    * `kubectl exec -it spec-7664ff995c -c filebeat-container -- /bin/sh`
* Execute command inside pod `spec-7664ff995c`
    * `kubectl exec spec-7664ff995c env`
* Get pods metrics (RAM, CPU):
    * `kubectl top pods`
* Copy file logs.txt from pod to your local system (file appears in current kubectl directory)
    * `kubectl cp spec-7664ff995c:logs.txt copied_logs.txt`
* Remove all failed pods:
    * `kubectl delete pods --field-selector status.phase=Failed`
    
#### Deployments
* Create deployment
    * `kubectl create deployment hello-minikube --image=k8s.gcr.io/echoserver:1.4`
* Deployment logs
    * `kubectl logs deployment/metrics-server`
    * `kubectl logs deployment/metrics-server --previous`
    
#### Rollout
* Check status
    * `kubectl rollout status deployments/kubernetes-bootcamp`
* Revert to previous state (e.g. to previous version)
    * `kubectl rollout undo deployments/kubernetes-bootcamp`
    
#### Quick prototyping (without .yaml files) 
* Update deployment (better use .yaml)
    * `kubectl set image deployment/nginx-deployment nginx=nginx:1.16.1`
* Create new service and expose it to external traffic (better use .yaml)
    * `kubectl expose deployments/hello-minikube --type=NodePort --port=8080`
* Edit ingress
    * `kubectl edit ingress/hello-world`
    
#### Kubernetes API
* In one terminal:
    * `kubectl proxy`
* In another terminal:
    * `curl http://localhost:8001/`
    * `curl http://localhost:8001/version`
    * `curl http://localhost:8001/api/v1/namespaces/default/pods/hello-minikube-6ddfcc9757-xzs9w`

#### Recipes
* Show CPU/Memory limits for each pod:
    * `kubectl get po -o custom-columns="Name:metadata.name,CPU-limit:spec.containers[*].resources.limits.cpu"`
    * `kubectl get po -o custom-columns="Name:metadata.name,Memory-limit:spec.containers[*].resources.limits.memory"`
* Forward port 9876 (localhost) to 8086 (kubernetes cluster)
    * `kubectl port-forward service/influxdb 9876:8086`
    * `curl localhost:9876`
* Send http request from pod to service in same namespace:
    * `curl http://hello-world-service:8081`
* Find exposed service IP/Port:
    * Get IP - `kubectl config view | grep server`
    * Get Port - `kubectl get services | grep hello-minikube`
    * Send request - `curl 192.168.49.2:31911`
* Why pod keeps on restarting/getting killed?
    * `kubectl describe pods/pod-name-here`
    * Look for something like `Last State: Terminated; Reason: Error; Exit code: 137;`
* Pod is starting very slow (e.g. low cpu), k8s kills it without waiting long enough
    * Good - Set `failureThreshold: 24` and `periodSeconds: 10` to `livenessProbe:`
        * K8s will check pod every 10 seconds, up to 24 times
    * Bad - Set `initialDelaySeconds: 180` to `livenessProbe:`
        * Bad because k8s just waits for 180 seconds, without checking periodically
* Check if load balancing is working:
    * Find exposed service IP/Port
    * Send multiple requests
    * Look at each `pod` logs
* If pod gets recreated when deleted - you need to delete deployment:
    * `kubectl get deployments`
    * `kubectl delete deployments/siep-service-rest`
* Make sure pod only appears on nodes with some free disk space:
    * Add `ephemeralStorage: "200Mi"` to `resources:`
* Pod gets evicted because of logs in stdout, that break `ephemeralStorage` limit
    * Kubelet rotates logs when (they reach `containerLogMaxSize`, by default `10Mi`) and (they reach `containerLogMaxFiles`, by default 5)
    * But if `ephemeralStorage` limit is low and logs appear fast - kubelet won't have enough time to rotate logs
        * Alternative version - somebody increased values of `containerLogMaxSize` and `containerLogMaxFiles`, now stdout break `ephemeralStorage` limit
    * Fix - raise `ephemeralStorage` limit, for example up to `1Gi`, so kubelet has time to react
        * Alternative version - so stdout will fit into `ephemeralStorage` limit 
* Create deployment for tests:
    * `kubectl create deployment hello-minikube --image=k8s.gcr.io/echoserver:1.4` 
* Scale deployment
    * Scale
        * `kubectl scale deployments/hello-minikube --replicas=2`
    * Check status #1
        * `kubectl get ReplicaSets` (desired, current, ready)
    * Check status #2
        * `kubectl get deployments` (ready, up-to-date, available)
* Horizontal Pod Autoscaler (HPA)
    * Autoscale deployment:
        * `kubectl autoscale deployment hello-minikube --cpu-percent=50 --min=1 --max=3`
    * Get HPA:
        * `kubectl get hpa`
    * Delete HPA:
        * `kubectl delete hpa`
* List pods with more than 5 restarts (useful for monitoring)
    * `kubectl --kubeconfig=test-3.conf get pods | awk '$4>5'`
* List failed jobs (useful for monitoring)
    * `kubectl --kubeconfig=test-3.conf get jobs -o custom-columns=NAMESPACE:.metadata.namespace,NAME:.metadata.name,FAILED:.status.failed | awk '$3 ~ /^[0-9]+$/ && $3 > 0 {print $1, $2, $3}'`
