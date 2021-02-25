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
* Metrics server:
    * Install:
        * On minikube:
            * `minikube addons enable metrics-server`
        * Otherwise:
            * `kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml`
    * Verify:
        * `kubectl top nodes`
        * `kubectl get deployment/metrics-server --namespace kube-system`
        * `kubectl logs deployment/metrics-server --namespace kube-system`
        * `kubectl get --raw /apis/metrics.k8s.io/v1beta1/nodes/minikube`
        * `kubectl get --raw /apis/metrics.k8s.io/v1beta1/namespaces/kube-system/pods/storage-provisioner`
        * `kubectl top pods`
* Deploy and scale:
    * Copy file [scala.yaml](extras/php-apache.yaml) on the server
    * Deploy:
        * `kubectl apply --filename php-apache.yaml`
        * `kubectl top pods`        
    * Configure autoscaling:
        * `kubectl autoscale deployment php-apache --cpu-percent=50 --min=1 --max=3`
        * `kubectl get hpa`
    * Increase load:
        * `kubectl run -i --tty load-generator --rm --image=busybox --restart=Never -- /bin/sh -c "while sleep 0.01; do wget -q -O- http://php-apache; done"`
    * Verify autoscaling:
        * `kubectl get hpa`
        * `kubectl get deployments`
        * `kubectl get pods`

#### Problems
* Metrics server:
    * `Unable to fully scrape metrics from node minikube: x509: cannot validate certificate for 231.323.21.2 because it doesn't contain any IP SANs`
        * `kubectl edit deploy -n kube-system metrics-server`
        * Add `--kubelet-insecure-tls` one line higher than `kubelet-preferred-address-types=InternalIP,ExternalIP,Hostname`
