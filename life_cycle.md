# Cycle de vie des images / conteneurs

## Montrer docker Hub
* $ docker search ( --filter : peu performant, pas de tags, --format => formatter l'affichage via un Go Template "{{ .Name }}")
* $ docker pull [IMAGE:TAG]
* $ docker pull debian:12
* $ designation la plus fine de l'image, en rapport à d'autres contextes
  comme l'architecture CPU (AMD64,ARM, PPC ...)
  image:tag@sha256:[SHA256]

## manipulation d'images
* `docker images`ou `docker image list | grep -E deb.*` (préférer aux filtres)
* `docker image rm` ou `docker rmi`

## créer un container

* `$ docker run debian:12` (rien ne se passe et le conteneur s'arrête!)

### modifier la commande sous jacente

* `$ docker run debian:12 /bin/echo 'Hello world'`

### lancer un processus bloquant en arrière plan (le docker run ne dépend plus du shell courant)
* `docker run --name deb12 -d debian:12 sleep infinity`

# gestion du lancement de la commande sous jacent

* `docker start deb`
* `docker stop deb`

* `docker rm [-f]`: supprimé si arrêté ou avec -f ( --force) 

> docker run = docker create + docker start (+ docker exec)
* `docker create --name deb debian:12 /bin/echo 'Hello world'`

## Introspection sur le namespace PID

1. le processus lancé par docker est quand même associé par le namespace host de la vm
2. root peut supprimer ce processus mais les namespaces **mount** et **ipc** interdisent la communication inter processus entre l'extérieur et l'intérieur du ctn
3. à l'intérieur du container: `docker exec -it ctn bash` et `ps aux` montre que le PID a l'id 1 dans le namespace du ctn et on ne voit plus tous les autres pids
4. NB: pour sortir d'un ctn soit exit (termine le bash) ou **ctrl + p + q** (sans terminer)
5. quand on crée un container, un **cgroup** fils ou **cgroup** main lié au service **containerd**
6. ce cgroup est lié au pid host
7. on peut voir ce pid avec `docker inspect ctn --format "{{ .State }}"`
8. possibilité de désactiver le namespace pid avec docker run ... --pid=host (FAILLE BEANTE)

## surveiller les conteneurs

* `docker ps` : conteneurs en cours d’exécution
* `docker ps -a`:  tous conteneurs
* `docker ps -q`: afficher uniquement les identifiants
* `docker ps -f "name=..."`: afficher en filtrant par ex. sur le nom
* `docker stop|start|restart|rm (-f) $(docker ps aq -f "name=prefix_*")`

## voir les traces du processus en arrière plan (-d || -it)

1. si un ctn lancé de manière interactive (docker run ... -it)
2. on peut se détacher et réattacher le processus avec ctrl + p + q est `docker attach` ctn 
3. vs docker exec ... qui lui créer un nouveau processus
4. au lieu d'essayer de scruter les logs du pocessus lancé nous même docker nous donne directement `docker logs ctn`