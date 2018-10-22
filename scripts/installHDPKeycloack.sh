##https://www.howtoforge.com/linux_openldap_setup_server_client
##https://osc.github.io/ood-documentation/master/authentication/tutorial-oidc-keycloak-rhel7/install-keycloak.html

sudo yum install vim lsof java-1.8.0-openjdk-devel -y
wget https://downloads.jboss.org/keycloak/4.5.0.Final/keycloak-4.5.0.Final.zip -O /home/vagrant/keycloak-4.5.0.Final.zip
unzip keycloak-4.5.0.Final.zip -d /opt/keycloak
ln -s /opt/keycloak-4.5.0.Final /opt/keycloack
sudo groupadd -r keycloak
sudo useradd -m -d /var/lib/keycloak -s /sbin/nologin -r -g keycloak keycloak
sudo chown keycloak: -R /opt/keycloak-4.5.0.Final/


#Added ‘admin’ to ‘/opt/keycloak-3.1.0.Final/standalone/configuration/keycloak-add-user.json’, (re)start server to load user
# cd /opt/keycloak-3.1.0.Final if you are not already there

openssl rand -hex 20 # generate a password to use for admin user
sudo -u keycloak ./bin/add-user-keycloak.sh --user admin --password KEYCLOAKPASS --realm master
