FROM quay.io/centos/centos:stream9

LABEL author="matt"
LABEL created_at.year="2023"
LABEL created_at.date="2023-12-15"
LABEL stack="stack-java"
LABEL stack.version="1.0.0"

# TODO 1
# on travaille à partir de l'image quay.io/centos/centos:stream9
# on télécharge tomcat via https://downloads.apache.org/tomcat/
RUN mkdir /opt/tomcat
ADD https://downloads.apache.org/tomcat/tomcat-10/v10.1.17/bin/apache-tomcat-10.1.17.tar.gz /opt/tomcat
# URL https://downloads.apache.org/tomcat/tomcat-10/v10.1.17/bin/apache-tomcat-10.1.17.tar.gz
# décompresser l'archive dans le dossier à créer /opt/tomcat
RUN tar -xvzf /opt/tomcat/apache-tomcat-10.1.17.tar.gz -C /opt/tomcat
RUN rm -f apache-tomcat-10.1.17.tar.gz
# installer java en nettoyant les paquets non désiré 
# yum update -y && yum install -y -q java && yum clean all
RUN yum update -y && yum install -y java && yum clean all
# nettoyer le téléchargement

# TODO2 changer le dossier home de l'utilisateur vers /opt/tomcat/tomcat.../webapps
WORKDIR /opt/tomcat/apache-tomcat-10.1.17/webapps/

# TODO3 télécharger l'application sample https://tomcat.apache.org/tomcat-10.1-doc/appdev/sample/sample.war dans le dossier home 
ADD https://tomcat.apache.org/tomcat-10.1-doc/appdev/sample/sample.war sample.war

# TODO4 persister le dossier home pour accéder ou sauvegarder les apps
VOLUME /opt/tomcat/apache-tomcat-10.1.17/webapps/

# TODO5 pour communiquer avec httpd avec le port 8080
EXPOSE 8080

## pour concatener l'entrypoint et le cmd on doit utiliser l'écriture avec les tokens []
# TODO6 exécuter de manière statique (sans substitution) le binaire en foreground catalina.sh vs startup.sh ???
ENTRYPOINT ["/opt/tomcat/apache-tomcat-10.1.17/bin/catalina.sh"]
# TODO7 ajouter la sous commande pour lancer en one shot run ou start ???
CMD ["run"]
