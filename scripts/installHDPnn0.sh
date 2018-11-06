#https://data-flair.training/blogs/hadoop-2-6-multinode-cluster-setup/
#https://www.linode.com/docs/databases/hadoop/how-to-install-and-set-up-hadoop-cluster/
sudo yum install vim lsof -y
wget https://archive.apache.org/dist/hadoop/core/hadoop-2.9.1/hadoop-2.9.1.tar.gz
tar zxvf hadoop-2.9.1.tar.gz
ln -s hadoop-2.9.1 hadoop
# Set Hadoop-related environment variables
export HADOOP_HOME=/home/vagrant/hadoop
export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
export HADOOP_MAPRED_HOME=$HADOOP_HOME
export HADOOP_COMMON_HOME=$HADOOP_HOME
export HADOOP_HDFS_HOME=$HADOOP_HOME
export YARN_HOME=$HADOOP_HOME
export PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin

sudo sh -c "echo HADOOP_HOME=/home/vagrant/hadoop >> /etc/environment"
sudo sh -c "echo HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop >> /etc/environment"
sudo sh -c "echo HADOOP_MAPRED_HOME=$HADOOP_HOME >> /etc/environment"
sudo sh -c "echo HADOOP_COMMON_HOME=$HADOOP_HOME >> /etc/environment"
sudo sh -c "echo HADOOP_HDFS_HOME=$HADOOP_HOME >> /etc/environment"
sudo sh -c "echo YARN_HOME=$HADOOP_HOME >> /etc/environment"
sudo sh -c "echo export PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin >> /etc/environment"

sed -i '/configuration>$/d' $HADOOP_CONF_DIR/core-site.xml
cat <<EOF >>$HADOOP_CONF_DIR/core-site.xml
 <configuration>
  <property>
    <name>fs.default.name</name>
    <value>hdfs://192.168.1.209:9000</value>
  </property>
  <property>
	 <name>hadoop.tmp.dir</name>
	  <value>/home/vagrant/hadoop/hdata</value>
	</property>
</configuration>
EOF
sed -i '/configuration>$/d' $HADOOP_CONF_DIR/hdfs-site.xml
cat <<EOF >>$HADOOP_CONF_DIR/hdfs-site.xml
<configuration>
  <property>
    <name>dfs.namenode.name.dir</name>
    <value>/home/vagrant/hadoop/data/nameNode</value>
  </property>
  <property>
    <name>dfs.datanode.data.dir</name>
    <value>/home/vagrant/hadoop/data/dataNode</value>
  </property>
	<property>
		<name>dfs.replication</name>
		<value>2</value>
	</property>
  <property>
     <name>dfs.permissions.superusergroup</name>
     <value>vagrant</value>
  </property>
</configuration>
EOF
cp $HADOOP_CONF_DIR/mapred-site.xml.template $HADOOP_CONF_DIR/mapred-site.xml
sed -i '/configuration>$/d' $HADOOP_CONF_DIR/mapred-site.xml
cat <<EOF >>$HADOOP_CONF_DIR/mapred-site.xml
<configuration>
  <property>
    <name>mapreduce.framework.name</name>
    <value>yarn</value>
  </property>
  <property>
    <name>yarn.app.mapreduce.am.resource.mb</name>
    <value>512</value>
  </property>

  <property>
    <name>mapreduce.map.memory.mb</name>
    <value>256</value>
  </property>

  <property>
    <name>mapreduce.reduce.memory.mb</name>
    <value>256</value>
  </property>
</configuration>
EOF
sed -i '/configuration>$/d' $HADOOP_CONF_DIR/yarn-site.xml
cat <<EOF >>$HADOOP_CONF_DIR/yarn-site.xml
<configuration>
  <property>
    <name>yarn.acl.enable</name>
    <value>0</value>
  </property>

  <property>
    <name>yarn.resourcemanager.hostname</name>
    <value>hdpnn</value>
  </property>

  <property>
    <name>yarn.nodemanager.aux-services</name>
    <value>mapreduce_shuffle</value>
  </property>
  <property>
    <name>yarn.nodemanager.resource.memory-mb</name>
    <value>1536</value>
  </property>

  <property>
    <name>yarn.scheduler.maximum-allocation-mb</name>
    <value>1536</value>
  </property>

  <property>
    <name>yarn.scheduler.minimum-allocation-mb</name>
    <value>128</value>
  </property>

  <property>
    <name>yarn.nodemanager.vmem-check-enabled</name>
    <value>false</value>
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
