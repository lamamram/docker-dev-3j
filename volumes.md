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