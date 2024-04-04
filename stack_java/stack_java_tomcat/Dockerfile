## nous allons utiliser une image centos 9: quay.io/centos/centos:stream9
FROM quay.io/centos/centos:stream9
## documenter l'image

LABEL author="matt"
LABEL created_at="2024-04-04"
LABEL stack="java"
LABEL stack.part="tomcat"

ARG TOMCAT_VERSION_MAJOR=9
ARG TOMCAT_VERSION_FULL=9.0.85

## ajouter un dossier /opt/tomcat
RUN mkdir /opt/tomcat

## injecter le fichier https://downloads.apache.org/tomcat/tomcat-9/v9.0.85/bin/apache-tomcat-9.0.85.tar.gz dans ce dossier
## décomprésser dans ce dossier sans dossier intermédiaire 
## installer java (yum)
## nettoyer les paquets yum
## ajouter un utilisateur tomcat avec le dossier /opt/tomcat comme home
## changer le home de l'image vers /opt/tomcat/webapps
# Optimisation des RUN pour ne créer qu'une seule couche => un seul état => + léger en disque
RUN curl https://downloads.apache.org/tomcat/tomcat-${TOMCAT_VERSION_MAJOR}/v${TOMCAT_VERSION_FULL}/bin/apache-tomcat-${TOMCAT_VERSION_FULL}.tar.gz \
    | tar -xvz -C /opt/tomcat/ --strip-components=1 && \
    yum update -q && yum install java -y -q && \
    yum clean all && \
    useradd -m -d /opt/tomcat -U tomcat

WORKDIR /opt/tomcat/webapps
## télécharger l'application sample https://tomcat.apache.org/tomcat-10.1-doc/appdev/sample/sample.war dans le dossier home 
ADD https://tomcat.apache.org/tomcat-10.1-doc/appdev/sample/sample.war .
## spécifier le propriétaire et groupe à tomcat
RUN chown -R tomcat:tomcat /opt/tomcat
## changer l'utilisateur à tomcat
USER tomcat
## persister le dossier home pour accéder ou sauvegarder les apps
VOLUME ["/opt/tomcat/webapps"]
## pour communiquer avec httpd avec le port 8080
## exécuter de manière statique (sans substitution) le binaire en foreground catalina.sh vs startup.sh ???
# ENTRYPOINT ["/opt/tomcat/bin/catalina.sh"]
## ajouter la sous commande pour lancer en one shot run ou start ???
CMD ["/opt/tomcat/bin/catalina.sh", "run"]

HEALTHCHECK \
  --interval=10s \
  --timeout=30s \
  --start-period=5s \
  --retries=3 \
  CMD grep "Server startup" /opt/tomcat/logs/catalina.*.log
