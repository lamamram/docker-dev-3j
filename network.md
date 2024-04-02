# réseaux Docker 

## réseau bridge par défaut "docker0"

* gamme d'ip internes à la vm: 172.17.0.0/16

* l'hôte (ici la vm) est la passerelle de ce sous réseau en 172.17.0.1

### forwarder un port de l'hôte sur un port du conteneur:

1. -p ou --publish port_externe:port_interne (associer un port externe avec un port interne)
  * $ `docker run --name nginx -d --restart unless-stopped -p 8080:80 nginx:1.25.4`
2. -p port_min-port_max:port_interne (choisir un port externe entre min et max)
  * $ `docker run --name nginx_range -d --restart unless-stopped -p 8080-8089:80 nginx:1.25.4`
3. -p IP|PORT_MIN-PORT_MAX:port_interne : idem avec restrictionsur l'interface
  * $ `docker run --name nginx_local -d --restart unless-stopped -p localhost:8082:80 nginx:1.25.4`
4. -P ou --publish-all: port random >= 32768
  * $ `docker run --name nginx_rand -d --restart unless-stopped -P nginx:1.25.4`

