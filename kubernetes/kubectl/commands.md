* Get list of pods in the namespace
    * `kubectl get pods`
* Print logs for pod `submod-7f9fdd6f87`
    * `kubectl logs submod-7f9fdd6f87`
* Shell into pod `spec-7664ff995c`
    * `kubectl exec -it spec-7664ff995c -- bash`
* Kill pod `fileman-38dj372j2h`
    * `kubectl delete pods fileman-38dj372j2h`
* Execute command `get pods` with `example.conf` configuration
    * `kubectl --kubeconfig=example.conf get pods`
* List services (IP/Ports) in the namespace
    * `kubectl get services`
* Print info about pod `spec-7664ff995c`
    * `kubectl get pod spec-7664ff995c -o yaml`
    * `kubectlf describe pods spec-7664ff995c`
