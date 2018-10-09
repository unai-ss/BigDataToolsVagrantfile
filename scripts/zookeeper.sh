#en el master
sudo yum install krb5-server krb5-libs krb5-auth-dialog krb5-workstation
sudo sed -i '/# default_realm = EXAMPLE.COM/default_realm = EXAMPLE.COM/g' /etc/krb5.conf
sudo sed -i '/# EXAMPLE.COM = \{/ EXAMPLE.COM = \{/g' /etc/krb5.conf
sudo sed -i '/# \}/  }/g' /etc/krb5.conf
sudo sed -i '/# kdc = keberos.example.com/kdc = hdpnn/g' /etc/krb5.conf
sudo sed -i '/# admin_server = keberos.example.com/kdc = hdpnn/g' /etc/krb5.conf
#pide password vagrant
sudo kdb5_util create -s
sudo kadmin.local
#esto se mete dentro de la shell de kadmin.local
addprinc -randkey hbase/hdpnn
addprinc -randkey zookeeper/hdpnn
addprinc -randkey hdfs/hdpnn
xst -k spnego.service.keytab hbase/hdpnn
xst -k spnego.service.keytab zookeeper/hdpnn
xst -k spnego.service.keytab zookeeper/hdpnn
#responden mal
xst -k spnego.service.keytab vagrant
xst -k spnego.service.keytab hdfs
xst -k spnego.service.keytab hbase
system
# en eel server
sudo yum install krb5-workstation -y
wget http://mirrors.ukfast.co.uk/sites/ftp.apache.org/zookeeper/zookeeper-3.4.10/zookeeper-3.4.10.tar.gz
tar xzf zookeeper-3.4.10.tar.gz
ln -s zookeeper-3.4.10 ./zookeeper
sudo chown -R vagrant:vagrant zookeeper-3.4.10
cd zookeeper
mkdir data
sudo cat <<EOF >>/home/vagrant/zookeeper/conf/zoo.cfg
tickTime=2000
initLimit=10
syncLimit=5
dataDir=/home/vagrant/zookeeper/data
clientPort=2181
server.1=hdpnn:2888:3888
server.2=hdpdn1:2888:3888
server.3=hdpdn2:2888:3888
EOF
#vagrant dependiendo de equipo.
sudo sh -c "echo '1' > /home/vagrant/zookeeper/data/myid"
sudo sh -c "echo '2' > /home/vagrant/zookeeper/data/myid"
sudo sh -c "echo '3' > /home/vagrant/zookeeper/data/myid"
