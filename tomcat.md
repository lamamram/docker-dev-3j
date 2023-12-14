# TODO 1
# on travaille à partir de l'image quay.io/centos/centos:stream9
# on télécharge tomcat via https://downloads.apache.org/tomcat/
# URL https://downloads.apache.org/tomcat/tomcat-10/v10.1.17/bin/apache-tomcat-10.1.17.tar.gz
# compresser l'archive dans le dossier à créer /opt/tomcat
# installer java en nettoyant les paquets non désiré 
# yum update -y && yum install -y -q java && yum clean all
# nettoyer le téléchargement

# TODO2 changer le dossier home de l'utilisateur vers /opt/tomcat/webapps

# TODO3 télécharger l'application sample https://tomcat.apache.org/tomcat-10.1-doc/appdev/sample/sample.war dans le dossier home 

# TODO4 persister le dossier home pour accéder ou sauvegarder les apps

# TODO5 pour communiquer avec httpd avec le port 8080

# TODO6 exécuter de manière statique (sans substitution) le binaire en foreground catalina.sh vs startup.sh ???

# TODO7 ajouter la sous commande pour lancer en one shot run ou start ???

