# Templates (.yaml)
#### Getting started. Pod
* Notice: naked pod will not be rescheduled in the event of a node failure. Better use `Deployment`
* Copy file [pong.yaml](extras/pong.yaml) to the server
* Apply the configuration:
    *  `kubectl apply --filename pong.yaml`
* Check created pod:
    * `kubectl get pods`
    * `kubectl logs pong-demo`
* Tear it down:
    * `kubectl delete --filename pong.yaml`

#### Getting started. Deployment + Service
* Copy file [bullet.yaml](extras/bullet.yaml) to the server
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
    * Copy file [scala.yaml](extras/php-apache.yaml) to the server
    * Deploy:
        * `kubectl apply --filename php-apache.yaml`
        * `kubectl top pods`        
    * Configure autoscaling:
        * Copy [file](extras/horizontal-pod-autoscaler.yaml) to the server 
        * Apply configuration:
            * `kubectl apply --filename horizontal-pod-autoscaler.yaml`
            * `kubectl get hpa`
    * Increase load:
        * `kubectl run -i --tty load-generator --rm --image=busybox --restart=Never -- /bin/sh -c "while sleep 0.01; do wget -q -O- http://php-apache; done" &`
    * Verify autoscaling:
        * `kubectl get hpa`
        * `kubectl get deployments`
        * `kubectl get pods`
    * Stop load:
        * `kubectl delete pod load-generator`
        * Wait for [cooldown/delay](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/#support-for-cooldown-delay)
        * Verify autoscaling again

#### Secrets
* Apply new secret:
    * Copy file [secret.yaml](extras/secret.yaml) to the server
    * `kubectl apply --filename secret.yaml`
    * Secret should appear in list - `kubectl get secrets`

#### ConfigMaps (env)
* Apply new secret:
    * Copy file [secret.yaml](extras/config-map.yaml) to the server
    * `kubectl apply --filename config-map.yaml`
    * ConfigMaps should appear in list - `kubectl get configmaps`
    
#### Vertical Pod Autoscaler
* Problem: app takes 2 cpu for quick start, after that 0.1 cpu is enough to work
    * Namespace limits are low, it won't be enough to set 2 cpu limit for each microservice
* Solution: set dynamic limits with Vertical Pod Autoscaler
* Look at [file](extras/vertical-pod-autoscaler.yaml)
    * Everything is ready, except for updateMode. Restart-free limit updates are still in development.
    * Wait for:
        * https://github.com/kubernetes/autoscaler/issues/4016
        * https://github.com/kubernetes/kubernetes/pull/102884
* 

#### Etc
* You have `docker run` command, want to execute it in k8s?
    * Convert it to .yaml for pod, example - `kafka-ui.yaml` (in kafka folder)

#### Problems
* Metrics server:
    * `Unable to fully scrape metrics from node minikube: x509: cannot validate certificate for 231.323.21.2 because it doesn't contain any IP SANs`
        * `kubectl edit deploy -n kube-system metrics-server`
        * Add `--kubelet-insecure-tls` one line higher than `kubelet-preferred-address-types=InternalIP,ExternalIP,Hostname`
* Deployment:
    * `Failed to pull image "registry.com/dfsljkfj8j2j3": rpc error: code = Unknown desc = Error response from daemon: Get registry.com/dfsljkfj8j2j3: denied: access forbidden`
    * Fix: Copy kubernetes secret from different namespace
 