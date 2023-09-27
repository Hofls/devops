#### Main
* If public docker images not always available, use [company proxy](https://docs.gitlab.com/ee/user/packages/dependency_proxy/)
    * Proxy returns the upstream image from a registry, acting as a pull-through cache
* Gitlab -> Group -> Packages & Registries -> Dependency Proxy -> get "Dependency Proxy image prefix"
    * Something like `vcs.someit.com/fias-evac/dependency_proxy/containers`
* Add in `.gitlab-ci.yml`:
    * `docker login -u $CI_DEPENDENCY_PROXY_USER -p $CI_DEPENDENCY_PROXY_PASSWORD $CI_DEPENDENCY_PROXY_SERVER`
* Replace `FROM` in `Dockerfile`:
    * `FROM vcs.someit.com:443/fias-evac/dependency_proxy/containers/openjdk:15-alpine`
* Replace `image` in `.gitlab-ci.yml`
    * `image: vcs.someit.com:443/fias-evac/dependency_proxy/containers/openjdk:15-alpine`

#### Problems
* If you need to pull through dependency proxy image from another repository (e.g. mcr.microsoft.com)
    * Bad way - manually push it to your dockerhub repository, then pull from it
    * Good way - todo
