# registry docker

## build

* gestion de TLS
* gestion d'une authentfication

* `docker login URL du registre https ou :5000 avec --username --password`

## utilisations des images

1. il faut renommer une image en tant qu'import sur le registre
   l'image doit être préfixée par le **nom_de_domaine:port** et
   on peut crée des noms d'espace `<nom_de_domaine:port>/name/space/<basename>:<tag>`   
   `docker tag <image> <new_reference>`

2. pousser une fois qu'on sera autentifié
   `docker push <new_reference>`

3. utiliser l'image depuis `docker pull`