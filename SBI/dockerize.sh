#!/bin/bash
export PATH="$PATH:/usr/local/bin"
#docker-compose build maven-app-image-docker
case $BRANCH_NAME in
  qa)
    tags=$(git describe | sed 's/-g[0-9a-f]\{7,8\}$//')
    tag="$BRANCH_NAME:$tags"
    dockerfile=Dockerfile.develop
    ;;
  develop)
    tags=$(git describe | sed 's/-g[0-9a-f]\{7,8\}$//')
    tag="$BRANCH_NAME:$tags"
    dockerfile=Dockerfile.develop
    ;;
  master)
    tags=$(git describe | sed 's/-g[0-9a-f]\{7,8\}$//')
    tag="$BRANCH_NAME:$tags"
    dockerfile=Dockerfile.develop
    ;;
  *)
    tags=$(git describe | sed 's/-g[0-9a-f]\{7,8\}$//')
    tag="$BRANCH_NAME:$tags"
    dockerfile=Dockerfile.tag
esac

services=$(cat $(dirname $0)/service-manifest.txt)
for s in $services
do
docker build -t ${s}:$tag -f $(dirname $0)/docker/$dockerfile .
done
