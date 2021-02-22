##### Terminology
* `Kubernetes` - tool for containers management
* Good defaults:
    * Run minimum 2 containers (if 1 stops unexpectedly, another will carry on)
    * Add/remove containers based on load
* `Cluster` => `Nodes` => `Pods` => `Containers`:
	* `Cluster` -  set of `Nodes` that run containerized applications
	* `Node` - virtual machine, contains services necessary to run Pods
	* `Pod` - wrapper around one or more `Containers`, with shared filesystem/network
	* `Container` - application packaged with everything it needs (runtime environment, external dependencies)
* `Deployment Controller` handles:
	* Pods creation, based on PodTemplates (YAML)
	* `Replication` - horizontal scaling of application (running more instances)
	* `Automatic healing` (restarts failed containers)
* `Service` - exposes pods as a network service (with their own IP, DNS name and load balancing)
* `ReplicaSet` - maintains stable number of replica pods running
* `Scaling` - changing the number of replicas in a Deployment (multiple replica pods in 1 node)
* `NodePort` - opens a port, forwards traffic to the service (pod)
* TODO:
    * https://kubernetes.io/docs/tutorials/kubernetes-basics/scale/scale-intro/
    * https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale-walkthrough/

##### Web UI (Dashboard)
* https://kubernetes.io/docs/tasks/access-application-cluster/web-ui-dashboard/
