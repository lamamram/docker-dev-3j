#!/bin/bash
[[ -z $(docker ps -aq) ]] \
|| docker stop $(docker ps -aq -f name=stack-php) \
&& docker rm $(docker ps -aq -f name=stack-php)

docker network rm stack-php
# ne pas oublier de détruire le volume nommé tant qu'on expérimente
# ou gérer uniquement le volume après les autres configuration
docker volume rm db_data

docker network create stack-php --driver=bridge --subnet=172.18.0.0/16 --gateway=172.18.0.1

# -e MARIADB_USER=test \
# -e MARIADB_PASSWORD=roottoor \
# -e MARIADB_DATABASE=test \
# -e MARIADB_ROOT_PASSWORD=roottoor \

## toujours essayer d'utiliser des conteneurs "one shot" pour tester les
## exemple
# docker run \
# -it --rm \
# --net stack-php \
# mariadb:10.11.6 \
# mariadb --host stack-php-mariadb --user test --password --database test

docker run \
--name stack-php-mariadb \
-d --restart unless-stopped \
--env-file /vagrant/.env \
--net stack-php \
-v db_data:/var/lib/mysql \
-v /vagrant/mariadb-init.sql:/docker-entrypoint-initdb.d/mariadb-init.sql \
mariadb:10.11.6


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
