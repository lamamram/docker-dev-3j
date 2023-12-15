FROM quay.io/centos/centos:stream9

LABEL author="matt"
LABEL created_at.year="2023"
LABEL created_at.date="2023-12-15"
LABEL stack="stack-java"
LABEL stack.version="1.0.0"

ARG VERSION_MAJOR
ARG VERSION_FULL

RUN mkdir /opt/tomcat
ADD https://downloads.apache.org/tomcat/tomcat-${VERSION_MAJOR}/v${VERSION_FULL}/bin/apache-tomcat-${VERSION_FULL}.tar.gz /opt/tomcat
# minimiser les couches avec un seul RUN une fois que les commandes ont été validées
RUN tar -xvzf /opt/tomcat/apache-tomcat-${VERSION_FULL}.tar.gz -C /opt/tomcat && \
    rm -f apache-tomcat-${VERSION_FULL}.tar.gz && \
    yum update -y && yum install -y java && yum clean all && \
    mv /opt/tomcat/apache-tomcat-${VERSION_FULL} /opt/tomcat/base 
# ajouter un utilisateur non root et ajouter le propriétaire du dossier contenant les apps 
# et les binaires de tomcat
RUN useradd -m -U -d /opt/tomcat/ tomcat
# TODO2 changer le dossier home de l'utilisateur vers /opt/tomcat/tomcat/base/webapps
WORKDIR /opt/tomcat/base/webapps/

# TODO3 télécharger l'application sample https://tomcat.apache.org/tomcat-10.1-doc/appdev/sample/sample.war dans le dossier home 
ADD https://tomcat.apache.org/tomcat-${VERSION_MAJOR}.1-doc/appdev/sample/sample.war sample.war
RUN chown -R tomcat:tomcat /opt/tomcat
# on change l'utilisateur pour sécuriser le lancement du container, et l'accès au mode interactif
# REM: la directive WORKDIR écrase le home initial de l'utilisateur même quand le chgt
# arrive après le WORKDIR
USER tomcat
WORKDIR /opt/tomcat/base/webapps/
# TODO4 persister le dossier home pour accéder ou sauvegarder les apps
VOLUME /opt/tomcat/base/webapps/

# TODO5 pour communiquer avec httpd avec le port 8080
EXPOSE 8080

HEALTHCHECK --interval=5s --timeout=10s --start-period=5s --retries=3 \
CMD grep "Server startup" /opt/tomcat/base/logs/catalina.*.log

## pour concatener l'entrypoint et le cmd on doit utiliser l'écriture avec les tokens []
# TODO6 exécuter de manière statique (sans substitution) le binaire en foreground catalina.sh vs startup.sh ???
ENTRYPOINT ["/opt/tomcat/base/bin/catalina.sh"]
# TODO7 ajouter la sous commande pour lancer en one shot run ou start ???
CMD ["run"]
# CMD ["/opt/tomcat/base/bin/catalina.sh run"]