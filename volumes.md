# persistence des données

* 3 types de "volumes"
  1. bind mounts => pour injecter et persister des confs dans un conteneur
  2. named volumes => pour extraire ( et persister) les données d'un conteneur
  3. tmpfs mounts => pour accéder à des données sensibles en RAM le temps de l'exécution du conteneur

* par défaut, les volumes sont des dossiers stockés dans l'instance du docker local ou sur l'hôte