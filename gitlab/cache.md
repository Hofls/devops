### Cache
* Add in file `.gitlab-ci.yml`:
```
cache:
  untracked: true
  key: "$CI_PROJECT_NAME"
  paths:
    - disp/src/main/frontend/node_modules/
```
* Optimizations:
    * Add line `policy: pull`, to make cache read-only
    * If there is a lot of small files - add them to `.tar` before caching
