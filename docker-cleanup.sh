#!/bin/bash

docker ps | awk {'print $1'} | tail -n +1 | xargs docker stop
docker ps -a | awk {'print $1'} | tail -n +2 | xargs docker rm
docker images | grep none | awk {'print $3'} | xargs docker rmi
