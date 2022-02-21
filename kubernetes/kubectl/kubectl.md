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
* Find exposed service IP/Port:
    * Get IP - `kubectl config view | grep server`
    * Get Port - `kubectl get services | grep hello-minikube`
    * Send request - `curl 192.168.49.2:31911`
* Forward port 9876 (localhost) to 8086 (kubernetes cluster)
    * `kubectl port-forward service/influxdb 9876:8086`
* Check if load balancing is working:
    * Find exposed service IP/Port
    * Send multiple requests
    * Look at each `pod` logs
* If pod gets recreated when deleted - you need to delete deployment:
    * `kubectl get deployments`
    * `kubectl delete deployments/siep-service-rest`
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
