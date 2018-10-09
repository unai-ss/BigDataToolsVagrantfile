# hbase 1.2 standalone
sudo yum install gcc gcc-c++ make ssh rsync lsof vim -y
sudo wget http://apache.rediris.es/hbase/1.2.7/hbase-1.2.7-bin.tar.gz
sudo tar -C /home/vagrant/ -zxvf hbase-1.2.7-bin.tar.gz
sudo sed -i '/configuration>$/d' /home/vagrant/hbase-1.2.7/conf/hbase-site.xml
sudo chown -R vagrant:vagrant /home/vagrant/hbase-1.2.7
sudo cat <<EOF >>/home/vagrant/hbase-1.2.7/conf/hbase-site.xml
<configuration>
<property>
   <name>hbase.rootdir</name>
   <value>hdfs://hdpnn:8030/hbase</value>
</property>

<property>
  <name>hbase.zookeeper.quorum</name>
  <value>hdpnn,hdpdn1,hdpdn2</value>
</property>

<property>
   <name>hbase.zookeeper.property.dataDir</name>
   <value>/home/vagrant/zookeeper</value>
</property>

<property>
  <name>hbase.cluster.distributed</name>
  <value>true</value>
</property>
</configuration>
<property>
    <name>hbase.security.authentication</name>
    <value>kerberos</value>
</property>
EOF
sudo cat <<EOF >>/home/vagrant/hbase-1.2.7/conf/regionservers
hdbnn
hdpdn1
hdpdn2
EOF
export HBASE_HOME=/home/vagrant/hbase-1.2.7
export HBASE_LOG_DIR=$HBASE_HOME/log
export HBASE_PID_DIR=$HBASE_HOME/run
export HBASE_USER=vagrant
export HBASE_GROUP=vagrant
export PATH=$PATH:$HBASE_HOME/bin
sudo sh -c "export HBASE_HOME=/home/vagrant/hbase-1.2.7 >> /etc/environment"
sudo sh -c "export HBASE_LOG_DIR=$HBASE_HOME/log >> /etc/environment"
sudo sh -c "export HBASE_PID_DIR=$HBASE_HOME/run >> /etc/environment"
sudo sh -c "export HBASE_USER=vagrant >> /etc/environment"
sudo sh -c "export HBASE_GROUP=vagrant >> /etc/environment"
sudo sh -c "export PATH=$PATH:$HBASE_HOME/bin >> /etc/environment"
sudo systemctl stop firewalld
