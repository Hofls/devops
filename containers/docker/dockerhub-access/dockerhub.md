### Problem
[Docker Hub](https://hub.docker.com/) returns error - `403 Forbidden` \
Because of that, proxy cache in your `Harbor` returns error - `Failed to pull image, artifact not found` 

### Solution
* Configure docker to use registry mirror: \
`"registry-mirrors": ["https://mirror.gcr.io", "https://daocloud.io", "https://c.163.com/", "https://registry.docker-cn.com"]`
* Pull image from `Docker Hub` via mirror:
`docker pull alpine:3.9.4`
* Login to your `Harbor`:
`docker login -u hofls -p qwerty harbor.someit.com`
* Tag an image with `Harbor` path:
`docker tag alpine:3.9.4 harbor.someit.com/library/alpine:3.9.4`
* Push to your `Harbor`:
`docker push harbor.someit.com/library/alpine:3.9.4`
