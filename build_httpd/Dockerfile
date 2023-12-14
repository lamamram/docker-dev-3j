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

COPY java_app.conf /usr/local/apache2/conf/sites/java_app.conf

# déclarer l'ouvertre d'un port pour la communication inter container
EXPOSE 80

# écriture avec tokens
# CMD [ "httpd", "-D", "FOREGROUND" ]
# REM la directive CMD lance une commande par défaut dans le docker run
# elle peut être substituée par la commande potentielle ajoutée
# à la fin du "docker run"
CMD httpd -D FOREGROUND