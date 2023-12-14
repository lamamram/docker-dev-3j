# image de base
FROM httpd:2.4

# métadonnée pour décrire l'image et filtrer l'image
LABEL author="matt"
LABEL created_at.year="2023"
LABEL created_at.date="2023-12-14"
LABEL stack="stack-java"
LABEL stack.version="1.0.0"

# injecter des fichiers depuis le dossier de travail (contexte du build) vers l'image
COPY httpd.conf /usr/local/apache2/conf/httpd.conf

# exécution de commandes
RUN mkdir /usr/local/apache2/conf/sites

