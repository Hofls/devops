### Info
* `Helm` - package manager for kubernetes
    * Use case #1 - execute one command to run app on k8s (e.g. grafana + prometheus)
    * Usa case #2 - package and distribute your app
    * Use case #3 - deploy your app on k8s (dev/test/stage/prod) using 1 template (and different values)
        * For this use case also consider Kustomize
* `Chart` - helm package
    * `Template` - base for generating k8s yaml files
    * `Values` - inserted into template
    * `Template` + `Values` = `k8s yaml`
* `Repository` - charts storage
* `Release` - instance of a chart running in a k8s cluster
* [ArtifactHUB](https://artifacthub.io/packages/search?kind=0) - list of public packages
* `Helm vs Kustomize`
    * Helm is great at packaging and distribution
    * Kustomize is great at "templates" (actually patches)

#### Getting started. CLI
* Install [minikube](../minikube/minikube.md)
* Install helm:
    * `apt update && apt install snapd`
    * `snap install helm --classic`
    * `helm version`
* Install chart:
    * Add repository - `helm repo add ealenn https://ealenn.github.io/charts`
    * Look at charts in repository - `helm search repo ealenn`
    * Install chart - `helm install ealenn/echo-server --generate-name`
    * Check status - `helm list` or `kubectl get pods`
* Render template:
    * Copy [hello-world](charts/hello-world) to the server
    * `helm template hello-world`
    
#### Examples

    
#### Helm. Commands
* `helm list` - list of deployed releases
* `helm upgrade` - install new release version
* `helm uninstall mysql-1612624192` - uninstall release
* Create & use chart:
    * `helm create deis-workflow` - create new chart
    * `helm install --debug --dry-run deis-workflow ./deis-workflow` - dry run (to check generated yaml)
    * `helm lint` - validate chart (execute from chart folder)
    * `helm package deis-workflow` - package chart for distribution (creates .tgz file)
    * `helm install deis-workflow ./deis-workflow-0.1.0.tgz` - install chart
    * `helm get manifest deis-workflow` - show generated yaml file for k8s
* Templates:
    * `helm template hello-world` - render template (replace placeholders with values)

#### Etc
* Error `UPGRADE FAILED: "hello-world-service" has no deployed releases`
    * Fix - Remove value `sh.helm.release.v1.hello-world-service.v1` from kubernetes secrets (or remove apps/release/hello-world)
* Deploy with helm to different k8s:
    * Set environment variable $KUBECONFIG
    * Value - content of a file, [example](../kubectl/extras/example.conf)
