# hbase 1.2 standalone
sudo yum install gcc gcc-c++ make ssh rsync lsof vim -y
sudo wget http://apache.rediris.es/hbase/1.2.7/hbase-1.2.7-bin.tar.gz
sudo wget http://apache.rediris.es/hadoop/common/stable/hadoop-2.9.1.tar.gz
sudo tar -C /home/vagrant/ -zxvf hbase-1.2.7-bin.tar.gz
sudo tar -C /home/vagrant/ -zxvf hadoop-2.9.1.tar.gz
sudo sed -i 's/# export JAVA_HOME=\/usr\/java\/jdk1.6.0\//export JAVA_HOME=\/usr\/java\/jdk1.8.0_181-amd64\//g' /home/vagrant/hbase-1.2.7/conf/hbase-env.sh
sudo sed -i '/configuration>$/d' /home/vagrant/hbase-1.2.7/conf/hbase-site.xml
sudo cat <<EOF >>/home/vagrant/hbase-1.2.7/conf/hbase-site.xml
<configuration>
  <property>
    <name>hbase.rootdir</name>
    <value>hdfs://localhost:8020/hbase</value>
  </property>
  <property>
    <name>hbase.zookeeper.property.dataDir</name>
    <value>/home/vagrant/zookeeper</value>
  </property>
  <property>
    <name>hbase.unsafe.stream.capability.enforce</name>
    <value>false</value>
    <description>
      Controls whether HBase will check for stream capabilities (hflush/hsync).

      Disable this if you intend to run on LocalFileSystem, denoted by a rootdir
      with the 'file://' scheme, but be mindful of the NOTE below.

      WARNING: Setting this to false blinds you to potential data loss and
      inconsistent system state in the event of process and/or node failures. If
      HBase is complaining of an inability to use hsync or hflush it's most
      likely not a false positive.
    </description>
  </property>
  <property>
  <name>hbase.cluster.distributed</name>
  <value>true</value>
</property>
</configuration>
EOF
export HBASE_LOG_DIR=/var/log/hbase
export HBASE_PID_DIR=/var/run/hbase
export HBASE_USER=hbase
export HBASE_GROUP=hadoop
export HBASE_HOME=/usr/lib/hbase/
export PATH=$PATH:$HBASE_HOME/bin
sudo sh -c "export HBASE_LOG_DIR=/var/log/hbase >> /etc/environment"
sudo sh -c "export HBASE_PID_DIR=/var/run/hbase >> /etc/environment"
sudo sh -c "export HBASE_USER=hbase >> /etc/environment"
sudo sh -c "export HBASE_GROUP=hadoop >> /etc/environment"
sudo sh -c "export HBASE_HOME=/usr/lib/hbase/ >> /etc/environment"
sudo sh -c "export PATH=$PATH:$HBASE_HOME/bin >> /etc/environment"
sudo systemctl stop firewalld
sudo /home/vagrant/hbase-1.2.7/bin/start-hbase.sh
echo 'HBase 1.2 standalone running ...'
