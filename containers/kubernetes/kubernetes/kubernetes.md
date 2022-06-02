##### Terminology
* `Kubernetes` - tool for containers management
* Good defaults:
    * Run minimum 2 containers (if 1 stops unexpectedly, another will carry on)
    * Add/remove containers based on load
* `Cluster` => `Nodes` => `Deployment` => `Pods` => `Containers`:
	* `Cluster` -  set of `Nodes` that run containerized applications
	* `Node` - virtual machine, contains services necessary to run Pods
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
        * `NodePort` - Makes a Service accessible from outside the cluster using <NodeIP>:<NodePort>
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
    * Everything else is rare: `ReplicaSet`, `Pod`, `Job`, `ReplicationController`...

##### Etc
* Lens (GUI):
    * `File -> Add Cluster -> Copy text from example.conf`
* To debug k8s network - use [busybox pod](templates/busybox.yaml)
    * Has ping, wget, traceroute
* Proxy port:
    * `kubectl --kubeconfig=example.conf proxy`
    * Open `http://127.0.0.1:8001`