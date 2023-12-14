# créer des images

## technique artisanale

1. travailler dans un conteneur en mode intéractif lié à une image de base qu'on veut surcharger
  * `docker run --name draft -it <image_base> /bin/bash`

2. modifier l'état du système de ficher pour installer et/ou configure etc.

3. sortir et utiliser le `docker diff` pour reviser les élements ajoutés

4. refabriquer uneimage à partir de l'état instantané du container
  * `docker commit <container name|ID> <new_image:new_tag>`
  * REM: si le container est live, docker commit arrête d'abord le container

## Dockerfile

