### Comprobar conexion ssh localhost
#   sudo groupadd hadoop
#   usermod -aG wheel vagrant
#   sudo usermod -aG wheel vagrant
#   sudo usermod -aG hadoop vagrant
#   ssh-keygen -t rsa -P ""
#   ssh-copy-id localhost
## Test
#   localhost


#https://data-flair.training/blogs/hadoop-2-6-multinode-cluster-setup/
#https://www.linode.com/docs/databases/hadoop/how-to-install-and-set-up-hadoop-cluster/
sudo yum install vim lsof -y
wget https://archive.apache.org/dist/hadoop/core/hadoop-2.6.4/hadoop-2.6.4.tar.gz
tar zxvf hadoop-2.6.4.tar.gz
ln -s hadoop-2.6.4 hadoop
# Set Hadoop-related environment variables
export HADOOP_HOME=/home/vagrant/hadoop
export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
export HADOOP_MAPRED_HOME=$HADOOP_HOME
export HADOOP_COMMON_HOME=$HADOOP_HOME
export HADOOP_HDFS_HOME=$HADOOP_HOME
export YARN_HOME=$HADOOP_HOME
export PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin

sh -c "echo HADOOP_HOME=/home/vagrant/hadoop >> ~/.bashrc"
sh -c "echo HADOOP_CONF_DIR=/home/vagrant/hadoop/etc/hadoop >> ~/.bashrc"
sh -c "echo HADOOP_MAPRED_HOME=/home/vagrant/hadoop >> ~/.bashrc"
sh -c "echo HADOOP_COMMON_HOME=/home/vagrant/hadoop >> ~/.bashrc"
sh -c "echo HADOOP_HDFS_HOME=/home/vagrant/hadoop >> ~/.bashrc"
sh -c "echo YARN_HOME=/home/vagrant/hadoop >> ~/.bashrc"
sh -c "echo PATH=$PATH:/home/vagrant/hadoop/sbin:/home/vagrant/hadoop/bin >> ~/.bashrc"

sudo sed -i '/configuration>$/d' $HADOOP_CONF_DIR/core-site.xml
sudo cat <<EOF >>$HADOOP_CONF_DIR/core-site.xml
 <configuration>
 <property>
   <name>hadoop.tmp.dir</name>
   <value>/app/hadoop/tmp</value>
   <description>A base for other temporary directories.</description>
  </property>

  <property>
   <name>fs.default.name</name>
   <value>hdfs://localhost:54310</value>
   <description>The name of the default file system.  A URI whose
   scheme and authority determine the FileSystem implementation.  The
   uri's scheme determines the config property (fs.SCHEME.impl) naming
   the FileSystem implementation class.  The uri's authority is used to
   determine the host, port, etc. for a filesystem.</description>
  </property>
 </configuration>
EOF
sed -i '/configuration>$/d' $HADOOP_CONF_DIR/hdfs-site.xml
cat <<EOF >>$HADOOP_CONF_DIR/hdfs-site.xml
<configuration>
  <property>
    <name>dfs.namenode.name.dir</name>
    <value>/home/vagrant/hadoop_store/data/nameNode</value>
  </property>
  <property>
    <name>dfs.datanode.data.dir</name>
    <value>/home/vagrant/hadoop_store/data/dataNode</value>
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

sudo mkdir -p /app/hadoop/tmp
sudo chown vagrant:vagrant /app/hadoop/tmp

mkdir -p /home/vagrant/hadoop_store/hdfs/namenode
mkdir -p /home/vagrant/hadoop_store/hdfs/datanode
chown -R vagrant:vagrant /home/vagrant/hadoop_store


hadoop namenode -format
