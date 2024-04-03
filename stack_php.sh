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
       --name stack_php_mariadb \
       -d --restart unless-stopped \
       --net stack_php \
       --env-file .env \
       -v ./mariadb-init.sql:/docker-entrypoint-initdb.d/mariadb-init.sql \
       mariadb:10.11.6 

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
       -v ./php8.2.conf:/etc/nginx/conf.d/php8.2.conf:ro \
       -p 8080:80 \
       nginx:1.25.4

