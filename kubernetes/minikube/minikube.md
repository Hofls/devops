##### Info
* `Minikube` - single-node Kubernetes cluster

##### Install
* Install docker
    * `apt install docker.io`
* Install minikube
    * `curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64`
    * `install minikube-linux-amd64 /usr/local/bin/minikube`
* Install kubectl
    * `apt install snapd`
    * `snap install kubectl --classic`

#### Use
* Run minikube:
    * `minikube start --force` (without `--force` won't run as root)
* Wait for all pods to start:
    * `kubectl get pods --all-namespaces`
* Create and check deployment:
    * `kubectl create deployment hello-minikube --image=k8s.gcr.io/echoserver:1.4`
    * 2 ways to check:
        * 1st - connect to pod:
            * `kubectl get pods`
            * `kubectl exec -it hello-minikube-6ddfcc9 -- bash`
            * `curl localhost:8080`
        * 2nd - expose NodePort:
            * `kubectl expose deployment hello-minikube --type=NodePort --port=8080`
            * `minikube service hello-minikube`
            * `curl 192.168.49.2:32350`

#### Clean up
* Services:
    * `kubectl get services`
    * `kubectl delete service hello-minikube`
* Deployment and pod:
    * `kubectl get pods`
    * `kubectl get deployments`
    * `kubectl delete deployment hello-minikube`
