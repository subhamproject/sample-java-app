#!/bin/bash
export PATH="$PATH:/usr/local/bin"
#docker-compose build maven-app-image-docker
case $BRANCH_NAME in
  qa)
   if [ -n "$(echo $BRANCH_NAME|grep '[a-zA-Z]')" ];then
    tags=$(git describe | sed 's/-g[0-9a-f]\{7,8\}$//')
    tag=$BRANCH_NAME-$tags
    dockerfile=Dockerfile.develop
    fi
    ;;
  develop)
  if [ -n "$(echo $BRANCH_NAME|grep '[a-zA-Z]')" ];then
    tags=$(git describe | sed 's/-g[0-9a-f]\{7,8\}$//')
    tag=$BRANCH_NAME-$tags
    dockerfile=Dockerfile.develop
    fi
    ;;
  master)
  if [ -n "$(echo $BRANCH_NAME|grep '[a-zA-Z]')" ];then
    tags=$(git describe | sed 's/-g[0-9a-f]\{7,8\}$//')
    tag=$BRANCH_NAME-$tags
   dockerfile=Dockerfile.develop
   fi
    ;;
  *)
  echo $BRANCH_NAME
    if [ -z "$(echo $BRANCH_NAME|grep '[a-zA-Z]')" ];then
    tags=$(git describe | sed 's/-g[0-9a-f]\{7,8\}$//')
    BRANCH=$(git branch --contains $BRANCH_NAME|head -1|cut -d' ' -f2)
    tag=$BRANCH-$tags
    dockerfile=Dockerfile.tag
    fi
esac

services=$(cat $(dirname $0)/service-manifest.txt)
for s in $services
do
docker build -t ${s}:$tag -f $(dirname $0)/docker/$dockerfile .
done
