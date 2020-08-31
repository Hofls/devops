#!/usr/bin/env bash

docker stop rest-back-container
docker container prune --force
docker image prune --force
docker build --tag rest-backend:1.0 .

docker run \
  --publish 8000:8080 \
  --name rest-back-container \
  --detach \
  --env-file ./environment.list \
rest-backend:1.0
