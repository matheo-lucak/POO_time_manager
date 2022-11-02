#!/usr/bin/env bash

docker-compose down
docker rm -f $(docker ps -a -q)
docker kill $(docker ps -q)
docker volume rm $(docker volume ls -q)
