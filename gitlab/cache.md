### Cache
* Add in file `.gitlab-ci.yml` (before build - download cache; after build - upload cache):
```
cache:
  untracked: true
  key: "$CI_PROJECT_NAME"
  paths:
    - disp/src/main/frontend/node_modules/
```
* Optimizations:
    * For bunch of small files (e.g. `node_modules`) [source](https://gitlab.com/gitlab-org/gitlab-runner/-/issues/1797):
        ```
        variables:
            FF_USE_FASTZIP: "true"
        ```
    * Refresh cache only if .lock file changed:
        ```
        - key:
            files:
              - dispatcher-web/package-lock.json
        ```
