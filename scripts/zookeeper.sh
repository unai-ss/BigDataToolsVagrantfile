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
