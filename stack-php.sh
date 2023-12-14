#!/bin/bash
[[ -z $(docker ps -aq) ]] \
|| docker stop $(docker ps -aq -f name=stack-php) \
&& docker rm $(docker ps -aq -f name=stack-php)

docker network rm stack-php

docker network create stack-php

docker run \
--name stack-php-php8 \
-d --restart unless-stopped \
--net stack-php \
--mount type=bind,src=/vagrant/index.php,dst=/srv/index.php \
bitnami/php-fpm:8.2-debian-11

docker run \
--name stack-php-nginx \
-d --restart unless-stopped \
-p 8080:80 \
--net stack-php \
-v /vagrant/php8.2.conf:/etc/nginx/conf.d/php8.2.conf:ro \
nginx:1.22