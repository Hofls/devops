#### General
* Print all events (logs)
    * `kubectl get events`
* Execute command `get pods` with [example.conf](extras/example.conf) configuration
    * `kubectl --kubeconfig=example.conf get pods`
* Show config
    * `kubectl config view`
    
#### Cluster
* Cluster info
    * `kubectl cluster-info`

#### Nodes
* List nodes
    * `kubectl get nodes`
* Node info
    * `kubectl describe nodes/minikube`

#### Pods
* Get list of pods in the namespace
    * `kubectl get pods`
* Show detailed info about pod `subv-fz9sd`
    * `kubectl describe pods/subv-fz9sd`
* Print logs for pod `submod-7f9fdd6f87`
    * `kubectl logs submod-7f9fdd6f87`
* Shell into pod `spec-7664ff995c`
    * `kubectl exec -it spec-7664ff995c -- bash`
* Print info about pod `spec-7664ff995c`
    * `kubectl get pods/spec-7664ff995c -o yaml`
    * `kubectlf describe pods/spec-7664ff995c`
* Kill pod `fileman-38dj372j2h`
    * `kubectl delete pods/fileman-38dj372j2h`
* Get pod metrics:
    * `kubectl top pods`
    
#### Deployments
* Create deployment
    * `kubectl create deployment hello-minikube --image=k8s.gcr.io/echoserver:1.4`
* List deployments
    * `kubectl get deployments`
* Deployment info
    * `kubectl describe deployments/hello-minikube`
* Update deployment
    * `kubectl set image deployment/nginx-deployment nginx=nginx:1.16.1`
* Deployment logs
    * `kubectl logs deployment/metrics-server`
* Delete deployment
    * `kubectl delete deployments/siep-service-rest`
    
#### Rollout
* Check status
    * `kubectl rollout status deployments/kubernetes-bootcamp`
* Revert to previous state (e.g. to previous version)
    * `kubectl rollout undo deployments/kubernetes-bootcamp`
    
#### Services
* List services (IP/Ports) in the namespace
    * `kubectl get services`
* Service info
    * `kubectl describe services/hello-minikube`
* Create new service and expose it to external traffic
    * `kubectl expose deployments/hello-minikube --type=NodePort --port=8080`
    
#### Scaling
* List ReplicaSets
    * `kubectl get ReplicaSets` (desired, current, ready)
* List deployments
    * `kubectl get deployments` (ready, up-to-date, available)
* Scale deployment
    * `kubectl scale deployments/hello-minikube --replicas=2`
    
#### Horizontal Pod Autoscaler (HPA)
* Autoscale deployment:
    * `kubectl autoscale deployment hello-minikube --cpu-percent=50 --min=1 --max=3`
* Get HPA:
    * `kubectl get hpa`
* Delete HPA:
    * `kubectl delete hpa`
    
#### Kubernetes API
* In one terminal:
    * `kubectl proxy`
* In another terminal:
    * `curl http://localhost:8001/`
    * `curl http://localhost:8001/version`
    * `curl http://localhost:8001/api/v1/namespaces/default/pods/hello-minikube-6ddfcc9757-xzs9w`
    
#### Recipes
* Create deployment for tests:
    * `kubectl create deployment hello-minikube --image=k8s.gcr.io/echoserver:1.4` 
* Find exposed service IP/Port:
    * Get IP - `kubectl config view | grep server`
    * Get Port - `kubectl get services | grep hello-minikube`
    * Send request - `curl 192.168.49.2:31911`
* Check if load balancing is working:
    * Find exposed service IP/Port
    * Send multiple requests
    * Look at each `pod` logs
* If pod gets recreated when deleted - you need to delete deployment:
    * `kubectl get deployments`
    * `kubectl delete deployments/siep-service-rest`

