#!/bin/bash

echo 'Deploying django-docker image with tag: '$1

echo 'Making sure the webapp is already running'$1
rancher-compose -f rancher/docker-compose.yml -r rancher/rancher-compose.yml -p docker-demo up -c -d webapp

echo 'Upgrade the webapp'$1
rancher-compose -f rancher/docker-compose.yml -r rancher/rancher-compose.yml -p docker-demo up --force-upgrade --pull -d webapp

echo 'Restart NGINX to correctly remap the services'
rancher-compose -f rancher/docker-compose.yml -r rancher/rancher-compose.yml -p docker-demo restart nginx
