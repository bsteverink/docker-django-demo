#!/bin/bash

echo 'Deploying django-docker image with tag: '$1

echo 'Replace the latest tag with the current build tag in the docker-compose file'
sed -i 's/demo:latest/demo:${BUILD_NUMBER}/' rancher/docker-compose.yml

echo 'Making sure the webapp is already running'$1
rancher-compose -f rancher/docker-compose.yml -r rancher/rancher-compose.yml -p docker-demo up -c -d webapp

echo 'Upgrade the webapp'$1
rancher-compose -f rancher/docker-compose.yml -r rancher/rancher-compose.yml -p docker-demo up --force-upgrade --pull -d webapp

echo 'Restart NGINX to correctly remap the services'
rancher-compose -f rancher/docker-compose.yml -r rancher/rancher-compose.yml -p docker-demo restart nginx
