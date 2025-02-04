#! /bin/bash

mkdir -p mnt-zk-01
mkdir -p mnt-zk-01-log
mkdir -p mnt-broker-01
mkdir -p mnt-broker-02
mkdir -p mnt-broker-03

chmod 777 -R mnt*

export DOCKER_HOST_IP=$(hostname -I |awk {'print $1'})
echo "$DOCKER_HOST_IP"
docker compose up -d
