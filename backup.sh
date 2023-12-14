#!/bin/bash

# conteneur one shot qui injecte les volumes d'un CONTENEUR
# pour exploiter un artifact (ici les données) d'un autre conteneur (ici mariadb)
docker run \
--rm \
-v /vagrant/backup:/backup \
--volumes-from stack-php-mariadb \
debian:12-slim  \
tar cvf /backup/backup.tar /var/lib/mysql