#!/usr/bin/env bash

count=$1
domainprefix=$2

touch /root/.ssh/config

for N in $(seq 1 $count); do
  echo "Host node$N" >> /root/.ssh/config
  echo "Hostname $domainprefix-docker-swarm-node-$((N-1)).furikuri.net" >> /root/.ssh/config
  echo "" >> /root/.ssh/config
done