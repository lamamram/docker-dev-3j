FROM httpd:2.4

LABEL author="matt"
LABEL created_at="2024-02-03"
LABEL created_at.year="2024"
LABEL stack="java"
LABEL stack.part="httpd"

ENV HOME=/
ENV SITES_DIR=/usr/local/apache2/conf/sites

ARG VHOST=java_app

## conf générale
COPY ./httpd.conf /usr/local/apache2/conf/httpd.conf

## on veut modifier qqch sur l'image de base
RUN mkdir -p ${SITES_DIR}

## injecter des fichiers / dossiers depuis l'host vers l'image
COPY ./java_app.conf ${SITES_DIR}/${VHOST}.conf
# lent
# ADD http://xxxxx.xxx/truc dest

# simple déclaration qui va intéresser un docker run de type -P --publish-all >32768->80 
EXPOSE 80
EXPOSE 443

# partie statique (non modifiable) de la commande par défaut de l'image
# pas obligatoire
ENTRYPOINT [ "httpd" ]
# partie dynamique (modifiable)     //
CMD [ "-D", "FOREGROUND" ]