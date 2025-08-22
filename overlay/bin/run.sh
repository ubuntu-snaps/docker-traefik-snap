#!/bin/bash

NAME="traefik"
IMAGE=$(snapctl get image)

for PLUG in docker docker-executables; do
  if ! snapctl is-connected $PLUG
  then
    echo "WARNING: $PLUG interface not connected! Please run: /snap/${SNAP_INSTANCE_NAME}/current/bin/setup.sh"
  fi
done

if [ ! "$(docker ps --all --quiet --filter name="$NAME")" ]; then
    echo "Container does not exist. Creating ..."
    docker create \
        --name "$NAME" \
        --restart=always \
        -p 80:80 \
        -p 443:443 \
        -v /var/run/docker.sock:/var/run/docker.sock \
        -v $SNAP_DATA:/etc/traefik \
        --env-file $SNAP_DATA/env.conf \
        "$IMAGE"
fi

echo "Starting container ..."
docker start --attach "$NAME"
