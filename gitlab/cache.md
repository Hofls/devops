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
    * Add line `policy: pull`, to make cache read-only
    * If you need to cache lot of small files - gitlab does a bad job
    * Best bet not to use gitlab cache at all. Better have persistent folder in a runner (e.g. `/home/gitlab-runner/.m2/repository/`) 
