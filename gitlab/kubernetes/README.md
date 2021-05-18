* Access fix:
    * Error - `deployments.apps "hello-world" is forbidden: User "system:serviceaccount:gitlab:gitlab-admin" cannot get resource "deployments" in API group "apps" in the namespace "temp-namespace"`
    * Gitlab -> Project -> Operations -> Kubernetes -> Add Kubernetes cluster -> Connect existing cluster
        * `API URL` - https://10.112.23.143:6443
        * `CA Certificate` - `-----BEGIN CERTIFICATE-----` ... `-----END CERTIFICATE-----`
        * `Service Token` - SDsd87dDK32dsf83DKAAfk334kdsDLFFJdl...
        * `RBAC-enabled cluster` - uncheck
        * `GitLab-managed cluster` - uncheck
 