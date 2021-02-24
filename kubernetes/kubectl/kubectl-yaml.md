# Templates (.yaml)
#### Getting started. Pod
* Disclaimer: naked pod will not be rescheduled in the event of a node failure. Better use `Deployment`
* Create file `pong.yaml` with text:
```
apiVersion: v1
kind: Pod
metadata:
  name: pong-demo
spec:
  containers:
  - name: testpod
    image: alpine:3.5
    command: ["ping", "8.8.8.8"]
```
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
