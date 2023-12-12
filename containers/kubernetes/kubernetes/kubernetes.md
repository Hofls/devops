##### Terminology
* `Kubernetes` - tool for containers management
* Good defaults:
    * Run minimum 2 containers (if 1 stops unexpectedly, another will carry on)
    * Add/remove containers based on load
* Typical path of http request: `Ingress` -> `Service` -> `Pod` -> `Container`
* `Cluster` => `Nodes` => `Deployment` => `Pods` => `Containers`:
	* `Cluster` -  set of `Nodes` that run containerized applications
	* `Node` - worker machine (often VM), contains services necessary to run Pods
	    * In case of a Node failure, identical Pods scheduled on other available Nodes in the cluster
	    * Contains a container runtime (e.g. Docker)
	* `Deployment Controller` handles:
            * `Deployment` - Pods creation (via kubectl, via PodTemplates (YAML))
            * `Replication` - horizontal scaling of application (running more instances)
            * `Automatic healing` - restarts failed containers
            * `Rollout` - deployment process
	* `Pod` - wrapper around one or more `Containers`, with shared filesystem/network
	    * Each pod has unique internal IP address (not exposed outside of cluster)
	    * Each pod has common external IP address (IP address of node)
	    * Usually 1 pod = 1 container
	* `Container` - application packaged with everything it needs (runtime environment, external dependencies)
* `Deployment` => `Service` (optional) / `Scaling` (optional)
    * `Service` - logical set of pods, exposes them as a network service (with their own IP, DNS name and load balancing)
        * `ClusterIP` - (default) exposes the Service on an internal IP in the cluster
        * `NodePort` - Makes a Service accessible from outside the cluster (look at "Direct access to service")
        * `LoadBalancer` - External load balancer with a fixed, external IP
            * Distributes traffic to all Pods of an exposed Deployment
        * `ExternalName` - Exposes the Service using an arbitrary name
    * `Scaling` - changing the number of replicas in a Deployment (multiple replica pods in 1 node)
        * `ReplicaSet` - maintains stable number of replica pods running
        * `Rolling updates` incremental pods update (with zero downtime)
* `Volume` - share files between containers, persistence
    * `emptyDir` - persists data on the pod (ephemeral, disappears with pod)
    * `hostPath` - persists data on the node (durable, stays forever)

* Workload resources
    * `kind: Deployment` - declarative updates for Pods 
        * You describe a desired state, controller changes the actual state to the desired state
        * Consists of `ReplicaSet`, `Pod`, `Container`
    * `kind: Service` - exposes application as a network service (available from other k8s pods)
        * e.g. `http://10.123.12.143:30663/` or `kafka-connect:8083`
        * Consists of `Endpoints`
    * `kind: Ingress` - manages external access to the services in a cluster, typically HTTP (also load balancing)
        * e.g. http://hello-world.k8s.someit.ru/
        * Ingress works for all nodes in a cluster (no way to make unique config for a single deployment)
    * `kind: ConfigMap` - sets environment variables
    * `kind: CronJob` - run `Job` on repeating schedule (e.g. backup DB every day)
        * Job is a pod that executes actions, then stops
        * Job stops with error without logs? Add `backofflimit: 10`, logs will be available while its trying again and again
        * Warning! K8s will refuse to run job if it fails often enough (e.g. if service is down)
            * `Cannot determine if job needs to be started. Too many missed start time (> 100)`
    * `kind: Secret` - store sensitive data (encoded with base64)
        * E.g. credentials to pull images from artifactory via `imagePullSecrets:`
    * Everything else is rare: `ReplicaSet`, `Pod`, `Job`, `ReplicationController`...

##### Etc
* Direct access to service (alternative to ingress):
    * Go to services, click on one, look for ports (something like `8080:31563/TCP`; only works with `NodePort`)
    * Get k8s IP address from kubeconfig
    * Construct direct access URL, e.g. `http://14.173.44.122:31563/shop/swagger-ui.html`
    * Also, by default nodePort (external port) is random, you may need to set it manually (just as you do with `port` and `targetPort`)
* Lens (GUI):
    * `File -> Add Cluster -> Copy text from example.conf`
* To debug k8s network - use [busybox pod](templates/busybox.yaml)
    * Has ping, wget, traceroute
    * To add curl - `opkg-install curl`
* Proxy port:
    * `kubectl --kubeconfig=example.conf proxy`
    * Open `http://127.0.0.1:8001`
* Probes:
    * `livenessProbe:` K8s kills pod on failure. Success means app is alive/running
        * Example - `failureThreshold: 3; timeoutSeconds: 5; periodSeconds: 6`
    * `readinessProbe:` K8s doesnt send traffic to a pod on failure. Success means app is ready to serve
        * Example - `failureThreshold: 3; timeoutSeconds: 5; periodSeconds: 6`
    * `startupProbe:` K8s kills pod on failure. All other probes are disabled until it succeeds. Success means app have started
        * Example - `initialDelaySeconds: 60, failureThreshold: 24; timeoutSeconds: 4; periodSeconds: 10`
* `ephemeral-storage:` - logs that go to stdout and stderr, any files created by container, emptyDir volumes you mount
