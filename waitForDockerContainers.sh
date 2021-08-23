#!/bin/bash

printf '\e[1;34m%-6s\e[m\n' "waiting for all services to become healthy to start ..."

NUM_CONTAINERS_STARTING="$(docker ps | grep '(health: starting)' | wc -l)"

while [ $NUM_CONTAINERS_STARTING != 0 ]
do
printf '\e[1;34m%-6s\e[m\n\n' "$NUM_CONTAINERS_STARTING containers are still starting"
docker ps
printf "waiting for 10 seconds ...\n\n"
sleep 10
NUM_CONTAINERS_STARTING="$(docker ps | grep '(health: starting)' | wc -l)"
done
printf '\e[1;34m%-6s\e[m\n' "no container in state (health: starting) ..."

docker ps

