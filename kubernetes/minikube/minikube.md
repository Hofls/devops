##### Info
* `Minikube` - single-node Kubernetes cluster

##### Install
* Install docker
    * `apt install docker.io`
    * `docker --version`
* Install minikube
    * `curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64`
    * `install minikube-linux-amd64 /usr/local/bin/minikube`
    * `minikube version`
* Install kubectl
    * Easy way:
        * `alias kubectl="minikube kubectl --"` (minikube should be running to use it)
    * Hard way:
        * `apt install snapd`
        * `snap install kubectl --classic`
        * `kubectl version`

#### Use
* Run minikube (pick 1 way):
    * As normal user:
        * `sudo su`
        * `apt install conntrack`
        * `usermod -a -G docker hofls`
        * Close SSH, login again as normal user
        * `minikube start --vm-driver=none`
    * With root privileges (not really working):
        * `minikube start --force`
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
* Minikube:
    * `minikube stop`