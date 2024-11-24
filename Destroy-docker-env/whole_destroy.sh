#!/bin/bash

echo "Destroying WHOLE docker environment..."

function remove_all {
  printf 'Are you sure? (y/n): '
  read input
  if [ "$input" = 'Y' -o "$input" = 'y' ]; then

    containers=$(docker ps -aq)
    if [ ! -z "$containers" ]; then
      docker stop $containers
      docker rm $containers
    fi

    docker network prune -f

    dangling_images=$(docker images --filter dangling=true -qa)
    if [ ! -z "$dangling_images" ]; then
      docker rmi -f $dangling_images
    fi

    dangling_volumes=$(docker volume ls --filter dangling=true -q)
    if [ ! -z "$dangling_volumes" ]; then
      docker volume rm $dangling_volumes
    fi

    all_images=$(docker images -qa)
    if [ ! -z "$all_images" ]; then
      docker rmi -f $all_images
    fi

    echo "Done."
  else
    echo "Aborted."
  fi
}

remove_all