#!/bin/bash
export PATH="$PATH:/usr/local/bin"
#docker-compose build maven-app-image-docker
case $BRANCH_NAME in
  qa)
    tag=$(git describe | sed 's/-g[0-9a-f]\{7,8\}$//')
    dockerfile=Dockerfile.develop
    ;;
  develop)
    tag=$(git describe | sed 's/-g[0-9a-f]\{7,8\}$//')
    dockerfile=Dockerfile.develop
    ;;
  master)
    tag=$(git describe | sed 's/-g[0-9a-f]\{7,8\}$//')
    dockerfile=Dockerfile.develop
    ;;
  *)
    tag=$(git describe | sed 's/-g[0-9a-f]\{7,8\}$//')
    tag="$BRANCH_NAME:$tag"
    dockerfile=Dockerfile.tag
esac

services=$(cat $(dirname $0)/service-manifest.txt)
for s in $services
do
docker build -t ${s}:$tag -f $(dirname $0)/docker/$dockerfile .
done
