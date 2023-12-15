# image de base
FROM httpd:2.4

# métadonnée pour décrire l'image et filtrer l'image
LABEL author="matt"
LABEL created_at.year="2023"
LABEL created_at.date="2023-12-14"
LABEL stack="stack-java"
LABEL stack.version="1.0.0"

ARG APP_NAME
ARG APP_CHECK

# injecter des fichiers depuis le dossier de travail (contexte du build) vers l'image
COPY httpd.conf /usr/local/apache2/conf/httpd.conf

# exécution de commandes
RUN mkdir /usr/local/apache2/conf/sites

COPY ${APP_NAME}.conf /usr/local/apache2/conf/sites/${APP_NAME}.conf
COPY ${APP_CHECK} /usr/local/${APP_CHECK}

# déclarer l'ouvertre d'un port pour la communication inter container
EXPOSE 80

# un HEALTHCHECK capable de scruter le service de manière temporaire
HEALTHCHECK --interval=5m --timeout=3s \
    CMD /usr/local/${APP_CHECK} || exit 1

# écriture avec tokens
# CMD [ "httpd", "-D", "FOREGROUND" ]
# REM la directive CMD lance une commande par défaut dans le docker run
# elle peut être substituée par la commande potentielle ajoutée
# à la fin du "docker run"
CMD httpd -D FOREGROUND