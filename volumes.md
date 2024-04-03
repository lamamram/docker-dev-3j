# persistence des données

* 3 types de "volumes"
  1. bind mounts => pour injecter et persister des confs dans un conteneur
  2. named volumes => pour extraire ( et persister) les données d'un conteneur
  3. tmpfs mounts => pour accéder à des données sensibles en RAM le temps de l'exécution du conteneur

* par défaut, les volumes sont des dossiers stockés dans l'instance du docker local ou sur l'hôte

## bind mounts

1. -v src_directory:dest_directory
  * :ro ou :readonly => une fois injecté, pas de MAJ dans le container si changement dans le host
  * `docker run --name stack_php_nginx -d -p 8080:80 -v ./php8.2.conf:/etc/nginx/conf.d/php8.2.conf:ro nginx:1.25.4`
    * REM: pour les volumes utilisants des fichier avec des chemins relatifs il faut spécifier le dossier d'origine "." ou ".., ../.., etc "

2. --mount type=bind,src=/vagrant/php8.2.conf,dst=/etc/nginx/conf.d/php8.2.conf,readonly
  * intérêt de --mount: utiliser le paramètre volume-opts (customiser le type de stockage)
  *  --mount key=value,...,
            volume-opt driver=local,
            volume-opt type=nfs
            volume-opt device=192.168.x.y:/storage

> remplace avantageusement le docker cp !!!

### volumes nommés

> étiquette qui désigne un dossier dans /var/lib/docker/volumes géré par docker

1. création rapide
  * -v name:/path/to/dir:ro
2. création à configurer
  * docker volume create [name] --opt=... --opt=... --driver=...
    + -v name:/path/to/dir
3. --mount type=volume,src=[name],...
4. volume anonyme
  * -v /var/lib/mysql
  > à utiliser avec l'option --volumes-from qui attache auto. les volumes d'un autre conteneur

### exemple d'utilisation de volumes nommés dump à chaud et à froid
```bash
# à chaud
docker run \
       --rm \
       --volumes-from stack_php_mariadb \
       -v ./dump:/dump \ 
       --net stack_php debian:12 \
       tar -czvf /dump/dump.gz /var/lib/mysql
```

```bash
# à froid: utilisation du volume nommé
docker run \
       --rm \
       -v db_data:/data \
       -v ./dump:/dump debian:12 \
       tar -czvf /dump/dump_cold.gz /data
```

### exemple de partage nfs
```bash
sudo apt-get install -y nfs-kernel-server
sudo mkdir -p /mnt/nfsdir
echo "contents" | sudo tee /mnt/nfsdir/test
# TEST
sudo chown -R nobody:nogroup /mnt/nfsdir
sudo chmod 777 /mnt/nfsdir
echo "/mnt/nfsdir *(rw,sync,no_subtree_check)" | sudo tee -a /etc/exports
sudo exportfs -a
sudo systemctl restart nfs-kernel-server
```

* création d'un volume docker nfs

```bash
docker volume create \
              --driver local \
              --opt type=nfs \
              --opt o=addr=192.168.1.30,rw \
              --opt device:/mnt/nfsdir \
              nfs-vol
```

* utilisation
`docker run --rm -v nfs-vol:/vol debian:12 cat /vol/test`






