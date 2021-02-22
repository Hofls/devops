#### Other
* Print all events (logs)
    * `kubectl get events`
* Execute command `get pods` with `example.conf` configuration
    * `kubectl --kubeconfig=example.conf get pods`
    
#### Cluster
* Cluster info
    * `kubectl cluster-info`

#### Nodes
* List nodes
    * `kubectl get nodes`
    
#### Deployments
* Create deployment
    * `kubectl create deployment kubernetes-bootcamp --image=gcr.io/google-samples/kubernetes-bootcamp:v1`
* List deployments
    * `kubectl get deployments`

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
    
#### Network
* Kubernetes API
    * In one terminal:
        * `kubectl proxy`
    * In another terminal:
        * `curl http://localhost:8001/`
        * `curl http://localhost:8001/version`
    
#### Services
* List services (IP/Ports) in the namespace
    * `kubectl get services`

#### Scaling
* List ReplicaSets
    * `kubectl get rs`
* List deployments
    * `kubectl get deployments`

#### Recipes
* If pod gets recreated when deleted - you need to delete deployment:
    * `kubectl get deployments`
    * `kubectl delete deployment siep-service-rest`