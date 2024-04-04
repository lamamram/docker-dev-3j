FROM httpd:2.4

LABEL author="matt"
LABEL created_at="2024-02-03"
LABEL created_at.year="2024"
LABEL stack="java"
LABEL stack.part="httpd"

## création et modification de variables d'environnement (à utliliser au moment du docker run
ENV HOME=/
ENV SITES_DIR=/usr/local/apache2/conf/sites
## création de variables à utiliser au moment du build
ARG VHOST=java_app

## conf générale
COPY ./httpd.conf /usr/local/apache2/conf/httpd.conf

## on veut modifier qqch sur l'image de base
RUN mkdir -p ${SITES_DIR} && \
    apt-get update -qq && \
    apt-get install -y wget && \
    apt-get autoclean && \
    rm -rf /var/lib/{apt/dpkg/cache/log}

## injecter des fichiers / dossiers depuis l'host vers l'image
COPY ./java_app.conf ${SITES_DIR}/${VHOST}.conf
# lent
# ADD http://xxxxx.xxx/truc dest

# simple déclaration qui va intéresser un docker run de type -P --publish-all >32768->80 
EXPOSE 80
EXPOSE 443

# partie statique (non modifiable) de la commande par défaut de l'image
# pas obligatoire
# ENTRYPOINT [ "httpd" ]
# partie dynamique (modifiable)     //
CMD ["httpd", "-D", "FOREGROUND" ]

HEALTHCHECK \
  --timeout=30s \
  --start-period=5s \
  CMD wget http://192.168.1.30:8081
