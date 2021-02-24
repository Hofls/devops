# Templates (.yaml)
#### Getting started. Pod
* Disclaimer: naked pod will not be rescheduled in the event of a node failure. Better use `Deployment`
* Copy file [pong.yaml](extras/pong.yaml) on the server
* Apply the configuration:
    *  `kubectl apply --filename pong.yaml`
* Check created pod:
    * `kubectl get pods`
    * `kubectl logs pong-demo`
* Tear it down:
    * `kubectl delete --filename pong.yaml`

#### Getting started. Deployment + Service
* Copy file [bullet.yaml](extras/bullet.yaml) on the server
* Apply the configuration:
    *  `kubectl apply --filename bullet.yaml`
* Check created objects:
    * `kubectl get deployments`
    * `kubectl get pods`
    * `kubectl get services`
* Send request:
    * `minikube service bb-entrypoint`
    * `curl 134.213.56.2:30001`
* Tear it down:
    * `kubectl delete --filename bullet.yaml`

#### Getting started. Horizontal Pod Autoscaler
* Naive way:
    * `kubectl create deployment hello-minikube --image=k8s.gcr.io/echoserver:1.4`
    * `kubectl autoscale deployments/hello-minikube --cpu-percent=50 --min=1 --max=3`
    * `kubectl get hpa`:
        ```
        NAME             REFERENCE                   TARGETS         MINPODS   MAXPODS   REPLICAS   AGE
        hello-minikube   Deployment/hello-minikube   <unknown>/50%   1         3         0          7s
        ```
    * Current CPU usage is unknown :(
* Metrics server:
    * Install:
        * `kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml`
    * Verify:
        * `kubectl get deployment/metrics-server --namespace kube-system`
        * `kubectl logs deployment/metrics-server --namespace kube-system`
* Copy file [scala.yaml](extras/scala.yaml) on the server
* 
* 



#### Problems
* Metrics server:
    * `Unable to fully scrape metrics from node minikube: x509: cannot validate certificate for 231.323.21.2 because it doesn't contain any IP SANs`
        * `kubectl edit deploy -n kube-system metrics-server`
        * Add `--kubelet-insecure-tls` one line higher than `kubelet-preferred-address-types=InternalIP,ExternalIP,Hostname`
