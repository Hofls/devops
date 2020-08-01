#!/usr/bin/env bash

docker rm rest-back-container --force
docker container prune --force
docker image prune --force
docker build --tag rest-backend:1.0 .
docker run --publish 8000:8099 --name rest-back-container --detach --env-file ./environment.list rest-backend:1.0
