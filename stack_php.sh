#!/bin/bash
# idempotence

[[ -z $(docker ps -aq) ]] \
|| docker rm -f $(docker ps -aq -f "name=stack_php_*")

docker network rm stack_php
docker network create \
       --driver=bridge \
       --subnet=172.18.0.0/16 \
       --gateway=172.18.0.1 \
       stack_php


docker run \
       --name stack_php_php8.2 \
       -d --restart unless-stopped \
       --network stack_php \
       -v ./index.php:/srv/index.php \
       bitnami/php-fpm:8.2-debian-12


docker run \
       --name stack_php_nginx \
       -d --restart unless-stopped \
       --network stack_php \
       -v ./php8.2.conf:/etc/nginx/conf.d/php8.2.conf \
       -p 8080:80 \
       nginx:1.25.4

