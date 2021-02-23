##### Terminology
* `Kubernetes` - tool for containers management
* Good defaults:
    * Run minimum 2 containers (if 1 stops unexpectedly, another will carry on)
    * Add/remove containers based on load
* `Cluster` => `Nodes` => `Pods` => `Containers`:
	* `Cluster` -  set of `Nodes` that run containerized applications
	* `Node` - virtual machine, contains services necessary to run Pods
	    * In case of a Node failure, identical Pods scheduled on other available Nodes in the cluster
	    * Contains a container runtime (e.g. Docker)
	* `Pod` - wrapper around one or more `Containers`, with shared filesystem/network
	    * Each pod has unique IP address (not exposed outside cluster)
	    * Usually 1 pod = 1 container
	* `Container` - application packaged with everything it needs (runtime environment, external dependencies)
* `Deployment` => `Service` (optional) / `Scaling` (optional)
    * `Deployment Controller` handles:
        * `Deployment` - Pods creation (via kubectl, via PodTemplates (YAML))
        * `Replication` - horizontal scaling of application (running more instances)
        * `Automatic healing` (restarts failed containers)
    * `Service` - logical set of pods, exposes them as a network service (with their own IP, DNS name and load balancing)
        * `ClusterIP` - (default) exposes the Service on an internal IP in the cluster
        * `NodePort` - Makes a Service accessible from outside the cluster using <NodeIP>:<NodePort>
        * `LoadBalancer` - External load balancer with a fixed, external IP
            * Distributes traffic to all Pods of an exposed Deployment
        * `ExternalName` - Exposes the Service using an arbitrary name
    * `Scaling` - changing the number of replicas in a Deployment (multiple replica pods in 1 node)
        * `ReplicaSet` - maintains stable number of replica pods running
        * `Rolling updates` incremental pods update (with zero downtime)

* TODO:
    * https://kubernetes.io/docs/tutorials/kubernetes-basics/scale/scale-intro/
    * https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale-walkthrough/

##### Web UI (Dashboard)
* https://kubernetes.io/docs/tasks/access-application-cluster/web-ui-dashboard/
