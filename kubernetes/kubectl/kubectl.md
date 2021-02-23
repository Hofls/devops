#### General
* Print all events (logs)
    * `kubectl get events`
* Execute command `get pods` with `example.conf` configuration
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
    * `kubectl describe node minikube`

#### Pods
* Get list of pods in the namespace
    * `kubectl get pods`
* Show detailed info about pod `subv-fz9sd`
    * `kubectl describe pod subv-fz9sd`
* Print logs for pod `submod-7f9fdd6f87`
    * `kubectl logs submod-7f9fdd6f87`
* Shell into pod `spec-7664ff995c`
    * `kubectl exec -it spec-7664ff995c -- bash`
* Print info about pod `spec-7664ff995c`
    * `kubectl get pod spec-7664ff995c -o yaml`
    * `kubectlf describe pods spec-7664ff995c`
* Kill pod `fileman-38dj372j2h`
    * `kubectl delete pod fileman-38dj372j2h`
    
#### Deployments
* Create deployment
    * `kubectl create deployment hello-minikube --image=k8s.gcr.io/echoserver:1.4`
* List deployments
    * `kubectl get deployments`
* Deployment info
    * `kubectl describe deployment hello-minikube`
    
#### Services
* List services (IP/Ports) in the namespace
    * `kubectl get services`
* Service info
    * `kubectl describe service hello-minikube`
* Create new service and expose it to external traffic
    * `kubectl expose deployment hello-minikube --type=NodePort --port=8080`
    
#### Kubernetes API
* In one terminal:
    * `kubectl proxy`
* In another terminal:
    * `curl http://localhost:8001/`
    * `curl http://localhost:8001/version`
    * `curl http://localhost:8001/api/v1/namespaces/default/pods/hello-minikube-6ddfcc9757-xzs9w`

#### Scaling
* List ReplicaSets
    * `kubectl get ReplicaSets` (desired, current, ready)
* List deployments
    * `kubectl get deployments` (ready, up-to-date, available)
* Scale deployment
    * `kubectl scale deployment hello-minikube --replicas=2`

#### Recipes
* If pod gets recreated when deleted - you need to delete deployment:
    * `kubectl get deployments`
    * `kubectl delete deployment siep-service-rest`
* Find exposed service IP/Port:
    * Get IP - `kubectl config view | grep server`
    * Get Port - `kubectl get services | grep hello-minikube`
    * Send request - `curl 192.168.49.2:31911`
* Check if load balancing is working:
    * Find exposed service IP/Port
    * Send multiple requests
    * Look at each `pod` logs

