wget http://mirrors.ukfast.co.uk/sites/ftp.apache.org/zookeeper/zookeeper-3.4.10/zookeeper-3.4.10.tar.gz
tar xzf zookeeper-3.4.10.tar.gz
ln -s zookeeper-3.4.10 ./zookeeper
sudo chown -R vagrant:vagrant zookeeper-3.4.10
cd zookeeper
mkdir data
sudo cat <<EOF >>/home/vagrant/zookeeper/conf/zoo.cfg
tickTime=2000
dataDir=/var/lib/zookeeper
clientPort=2181
EOF
#vagrant dependiendo de equipo.
sudo sh -c "echo '1' > /home/vagrant/zookeeper/data/myid"
sudo sh -c "echo '2' > /home/vagrant/zookeeper/data/myid"
sudo sh -c "echo '3' > /home/vagrant/zookeeper/data/myid"
