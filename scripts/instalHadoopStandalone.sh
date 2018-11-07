#https://data-flair.training/blogs/hadoop-2-6-multinode-cluster-setup/
#https://www.linode.com/docs/databases/hadoop/how-to-install-and-set-up-hadoop-cluster/
sudo yum install vim lsof -y
wget https://archive.apache.org/dist/hadoop/core/hadoop-3.1.1/hadoop-3.1.1.tar.gz
tar zxvf hadoop-3.1.1.tar.gz
ln -s hadoop-3.1.1 hadoop
sudo adduser hduser
sudo groupadd hadoop
sudo usermod -aG wheel hduser
sudo usermod -aG hadoop hduser
ssh-keygen -t rsa -P ""
cat $HOME/.ssh/id_rsa.pub >> $HOME/.ssh/authorized_keys
chmod og-wx ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
sudo mkdir -p /app/hadoop/tmp
sudo chown -R vagrant:hadoop /app/hadoop/tmp
# Set Hadoop-related environment variables
#HADOOP VARIABLES START

#HADOOP VARIABLES START
export HADOOP_HOME=/home/vagrant/hadoop
export HADOOP_INSTALL=/home/vagrant/hadoop
export PATH=$PATH:$HADOOP_INSTALL/bin
export PATH=$PATH:$HADOOP_INSTALL/sbin
export HADOOP_MAPRED_HOME=$HADOOP_INSTALL
export HADOOP_COMMON_HOME=$HADOOP_INSTALL
export HADOOP_HDFS_HOME=$HADOOP_INSTALL
export YARN_HOME=$HADOOP_INSTALL
export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_INSTALL/lib/native
export HADOOP_OPTS="-Djava.library.path=$HADOOP_INSTALL/lib"
export HADOOP_CONF_DIR=$HADOOP_INSTALL/etc/hadoop
#HADOOP VARIABLES END
#HADOOP VARIABLES END

sudo sh -c "echo HADOOP_INSTALL=/home/vagrant/hadoop >> ~/.bashrc"
sudo sh -c "echo PATH=$PATH:$HADOOP_INSTALL/bin >> ~/.bashrc"
sudo sh -c "echo PATH=$PATH:$HADOOP_INSTALL/sbin >> ~/.bashrc"
sudo sh -c "echo HADOOP_MAPRED_HOME=$HADOOP_INSTALL >> ~/.bashrc"
sudo sh -c "echo HADOOP_COMMON_HOME=$HADOOP_INSTALL >> ~/.bashrc"
sudo sh -c "echo HADOOP_HDFS_HOME=$HADOOP_INSTALL >> ~/.bashrc"
sudo sh -c "echo YARN_HOME=$HADOOP_INSTALL >> ~/.bashrc"
sudo sh -c "echo HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_INSTALL/lib/native >> ~/.bashrc"
sudo sh -c "echo HADOOP_OPTS="-Djava.library.path=$HADOOP_INSTALL/lib >> ~/.bashrc
sudo sh -c "echo HADOOP_HOME=$HADOOP_INSTALL >> ~/.bashrc"

#source ~/.bashrc

sed -i '/configuration>$/d' $HADOOP_CONF_DIR/core-site.xml
cat <<EOF >>$HADOOP_CONF_DIR/core-site.xml
 <configuration>
    <property>
      <name>hadoop.tmp.dir</name>
      <value>/app/hadoop/tmp</value>
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
      <value>file:/home/vagrant/hadoop_store/hdfs/namenode</value>
  </property>
  <property>
      <name>dfs.datanode.data.dir</name>
      <value>file:/home/vagrant/hadoop_store/hdfs/datanode</value>
  </property>
</configuration>
EOF
#cp $HADOOP_CONF_DIR/mapred-site.xml.template $HADOOP_CONF_DIR/mapred-site.xml
sed -i '/configuration>$/d' $HADOOP_CONF_DIR/mapred-site.xml
cat <<EOF >>$HADOOP_CONF_DIR/mapred-site.xml
<configuration>
<property>
 <name>mapred.job.tracker</name>
 <value>localhost:54311</value>
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

mkdir -p home/vagrant/hadoop_store/hdfs/namenode
mkdir -p home/vagrant/hadoop_store/hdfs/namenode

hadoop namenode -format
cat <<EOF >>/etc/systemd/system/hdfs.service
[Unit]
Description=Hadoop DFS namenode and datanode
After=syslog.target network.target remote-fs.target nss-lookup.target network-online.target
Requires=network-online.target

[Service]
User=vagrant
Group=hadoop
Type=simple
ExecStart=/home/vagrant/hadoop/sbin/start-all.sh
ExecStop=/home/vagrant/hadoop/sbin/stop-all.sh
WorkingDirectory=/home/vagrant
Environment=JAVA_HOME=/usr/java/jdk1.8.0_191-amd64
Environment=HADOOP_HOME=/home/vagrant/hadoop
TimeoutStartSec=1min
Restart=on-failure
PIDFile=/tmp/hadoop-vagrant-namenode.pid

[Install]
WantedBy=multi-user.target
EOF
sudo ln -s /usr/lib/systemd/hdfs.service /etc/systemd/system/hdfs.service
sudo systemctl daemon-reload
sudo systemctl start hdfs
