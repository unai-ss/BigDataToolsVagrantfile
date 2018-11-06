#https://data-flair.training/blogs/hadoop-2-6-multinode-cluster-setup/
#https://www.linode.com/docs/databases/hadoop/how-to-install-and-set-up-hadoop-cluster/
sudo yum install vim lsof -y
wget https://archive.apache.org/dist/hadoop/core/hadoop-2.9.1/hadoop-2.9.1.tar.gz
tar zxvf hadoop-2.9.1.tar.gz
ln -s hadoop-2.9.1 hadoop
sudo adduser hduser sudo
sudo groupadd hadoop
# Set Hadoop-related environment variables
#HADOOP VARIABLES START
export HADOOP_INSTALL=/usr/local/hadoop
export PATH=$PATH:$HADOOP_INSTALL/bin
export PATH=$PATH:$HADOOP_INSTALL/sbin
export HADOOP_MAPRED_HOME=$HADOOP_INSTALL
export HADOOP_COMMON_HOME=$HADOOP_INSTALL
export HADOOP_HDFS_HOME=$HADOOP_INSTALL
export YARN_HOME=$HADOOP_INSTALL
export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_INSTALL/lib/native
export HADOOP_OPTS="-Djava.library.path=$HADOOP_INSTALL/lib"
export HADOOP_HOME=$HADOOP_INSTALL
#HADOOP VARIABLES END

sudo sh -c "echo HADOOP_INSTALL=/usr/local/hadoop >> /etc/environment"
sudo sh -c "echo PATH=$PATH:$HADOOP_INSTALL/bin >> /etc/environment"
sudo sh -c "echo PATH=$PATH:$HADOOP_INSTALL/sbin >> /etc/environment"
sudo sh -c "echo HADOOP_MAPRED_HOME=$HADOOP_INSTALL >> /etc/environment"
sudo sh -c "echo HADOOP_COMMON_HOME=$HADOOP_INSTALL >> /etc/environment"
sudo sh -c "echo HADOOP_HDFS_HOME=$HADOOP_INSTALL >> /etc/environment"
sudo sh -c "echo YARN_HOME=$HADOOP_INSTALL >> /etc/environment"
sudo sh -c "echo HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_INSTALL/lib/native >> /etc/environment"
sudo sh -c "echo HADOOP_OPTS="-Djava.library.path=$HADOOP_INSTALL/lib >> /etc/environment
sudo sh -c "echo HADOOP_HOME=$HADOOP_INSTALL >> /etc/environment"

source /etc/environment

sed -i '/configuration>$/d' $HADOOP_CONF_DIR/core-site.xml
cat <<EOF >>$HADOOP_CONF_DIR/core-site.xml
 <configuration>
    <property>
      <name>hadoop.tmp.dir</name>
      <value>/app/hadoop/tmp</value>
      <description>A base for other temporary directories.</description>
   </property>
   <property>
      <name>fs.default.name</name>
      <value>hdfs://localhost:54310</value>
    </property>
</configuration>
EOF
sed -i '/configuration>$/d' $HADOOP_CONF_DIR/hdfs-site.xml
cat <<EOF >>$HADOOP_CONF_DIR/hdfs-site.xml
<configuration>
  <property>
      <name>dfs.replication</name>
      <value>1</value>
  </property>
  <property>
      <name>dfs.namenode.name.dir</name>
      <value>file:/usr/local/hadoop_store/hdfs/namenode</value>
  </property>
  <property>
      <name>dfs.datanode.data.dir</name>
      <value>file:/usr/local/hadoop_store/hdfs/datanode</value>
  </property>
</configuration>
EOF
cp $HADOOP_CONF_DIR/mapred-site.xml.template $HADOOP_CONF_DIR/mapred-site.xml
sed -i '/configuration>$/d' $HADOOP_CONF_DIR/mapred-site.xml
cat <<EOF >>$HADOOP_CONF_DIR/mapred-site.xml
<configuration>
    <property>
       <name>mapred.job.tracker</name>
       <value>localhost:54311</value>
    </property>

    <property>
      <name>mapreduce.framework.name</name>
      <value>yarn</value>
    </property>
  </configuration>
  EOF
  sed -i '/configuration>$/d' $HADOOP_CONF_DIR/yarn-site.xml
  cat <<EOF >>$HADOOP_CONF_DIR/yarn-site.xml
  <configuration>
  <property>
     <name>yarn.nodemanager.aux-services</name>
     <value>mapreduce_shuffle</value>
  </property>
</configuration>
EOF
cat <<EOF >$HADOOP_CONF_DIR/masters
hdpnn
EOF
cat <<EOF >$HADOOP_CONF_DIR/slaves
hdpdn1
hdpdn2
EOF
mkdir -p $HADOOP_HOME/data/nameNode
mkdir -p $HADOOP_HOME/data/dataNode
mkdir -p $HADOOP_HOME/hdata

cat <<EOF >>/home/vagrant/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDtTLp9ScSKB+gffdG7T4Zf99KSBF9zY88chXE6mzjBvVMRLBtvhFzgr/h49eA/J6yrB57ABPABPcXgoQ6IF7SSFCIX/LSrNdDW8SVB/4CJSHyv1nnjEXIiDPkUtP10SMBupmr44xeH8qJ0zp3Rmp7m83SX3TZnSY1lLJg28lQeUNMzR06o+rEFVeywaKfGUg4ZntcyZP29JQz7AoAb5IB/8A32jLKh1g+JanrvoJALYMrcChc7w/HYLCCBsxig8DH15MBCHcZxN9tQNOLxveIQF3u2Ole0QTK4RKHbCNO6w/e1tL9LhJjT6wGxoKv6s1XWH2I7JeG+D4rzu9Ia6d8Z vagrant@hdpnn
EOF
sudo touch /home/vagrant/hadoop-2.9.1/logs/hadoop-vagrant-datanode-hdpnn.out
#mkdir -p $HADOOP_HOME/hadoop_store/hdfs/namenode2
sudo chown -R vagrant:vagrant $HADOOP_HOME
#chmod 755 $HADOOP_HOME/hadoop_store/hdfs/namenode2

sudo systemctl stop firewalld
