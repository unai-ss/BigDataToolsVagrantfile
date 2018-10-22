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
sudo touch /home/vagrant/hadoop-2.9.1/logs/hadoop-vagrant-datanode-hdpnn.out
#mkdir -p $HADOOP_HOME/hadoop_store/hdfs/namenode2
sudo chown -R vagrant:vagrant $HADOOP_HOME
#chmod 755 $HADOOP_HOME/hadoop_store/hdfs/namenode2
cat <<EOF >/home/vagrant/.ssh/id_rsa
-----BEGIN RSA PRIVATE KEY-----
MIIEowIBAAKCAQEA7Uy6fUnEigfoH33Ru0+GX/fSkgRfc2PPHIVxOps4wb1TESwb
b4Rc4K/4ePXgPyesqweewATwAT3F4KEOiBe0khQiF/y0qzXQ1vElQf+AiUh8r9Z5
4xFyIgz5FLT9dEjAbqZq+OMXh/KidM6d0Zqe5vN0l902Z0mNZSyYNvJUHlDTM0dO
qPqxBVXssGinxlIOGZ7XMmT9vSUM+wKAG+SAf/AN9oyyodYPiWp676CQC2DK3AoX
O8Px2CwggbMYoPAx9eTAQh3GcTfbUDTi8b3iEBd7tjpXtEEyuESh2wjTusP3tbS/
S4SY0+sBsaCr+rNV1h9iOyXhvg+K87vSGunfGQIDAQABAoIBAFHLhuS0zrg9bXed
aPPFv63IwJ5wP26I0tUj8hmfc3rkhYN/zp0r5M/WGDGpnvhl9pClecT6brge0NxS
561lbmqD4hSemLADRs8wJAWRyn6Hq+L4bN8mHk86ZYkLsempQhth5bGQpYXIztKw
fZnIUEmPVXsbVytXIRPkwTr/YJtp2tPnxKsyPehT29j2jyi/DCpH2BVe8tYTXCxW
/UFlXXjWV2JSyXLo/3yW5TCqujHjwEp7S0HkzX7J8cCDyzxH+wUwTc79TTZ1/oCA
pSV+xl2OqQHgvTJCJuqWv+1bEXbnPoqXdjdt7JtIykZp5tXURkG0K7g410qd9kJS
xbPXhjkCgYEA+gbxOxeJYibd348mYkRBjW6H8HvXh4bNKC1BbWI/7/7W4lvF1Dxz
tboG3vWKo8yWyCuGW9kIc49JKhnH5vHYqZ2HIzmabacpdA5dm+K/ysUgVa6EBvpK
3Eh0Ea/rbbMhafWdHYylm2dMl3ODGO+YvCrXcC0pcRuh+FaSoJG2TlMCgYEA8vfz
bquK0PWFlIsZbZCXHyvqp7x6pcY3xlhzPxlCTWQoSQnsbVMFQvf0do/myvGMOVT5
y99MSJigxl+yTtpSoL31GCJiQPiec1T60fKMipup2tg1nKR7uttF01LEYlvCUEMp
0pQOM1SUBE4R0d+evFLtrYL0CWy4fjCJ/rbbd2MCgYBNyvEtqKIXRu6Ly3du5bvb
rINhYLbrtRaKJKKRzRsFqi3j2hgQdAqwhUP0BUPwuQxFFb3FQB7wDan/DmxzP9Zg
1+GfJSIWcgdk079ubDuudG0eG6F6pk+6gFSU2D6RMEX6OPB8rDEuzBI5oTgt/wZv
rYjAn1ygk69unEkc6pllfwKBgQDxWxm44DMfbCXr71mtGyrjzi5lvbdgIc2Z/JdP
IPpaApp6I5924jeh1MpFVKGBC/2tnhoeSY1vuB5NsRZhekMGZmyoMs/DlrVgABTA
pd6yeft657gqCMLYVaXBTMDErD4UmQNcqbKJjwUSWbMd9rOqg/6SlDlze0qyH+mU
23Sb3QKBgB9wHDUcA6rzQU02EnFLZQz4aKm45w/IyYq8Q9D9DK/pKMViqaDBPzKC
sM9v9eKpxZh3VG9ZzEsfZL1zcbDwOfSI4CRZvGPNCLl0MhJ1Sa63R9FEGcXeHAmJ
BTOuz5AGbzKdZ6WP5QuegEe8N+acUYZuiyWjUPOcbMiG/z6f0hDO
-----END RSA PRIVATE KEY-----
EOF
cat <<EOF >>/home/vagrant/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDtTLp9ScSKB+gffdG7T4Zf99KSBF9zY88chXE6mzjBvVMRLBtvhFzgr/h49eA/J6yrB57ABPABPcXgoQ6IF7SSFCIX/LSrNdDW8SVB/4CJSHyv1nnjEXIiDPkUtP10SMBupmr44xeH8qJ0zp3Rmp7m83SX3TZnSY1lLJg28lQeUNMzR06o+rEFVeywaKfGUg4ZntcyZP29JQz7AoAb5IB/8A32jLKh1g+JanrvoJALYMrcChc7w/HYLCCBsxig8DH15MBCHcZxN9tQNOLxveIQF3u2Ole0QTK4RKHbCNO6w/e1tL9LhJjT6wGxoKv6s1XWH2I7JeG+D4rzu9Ia6d8Z vagrant@hdpnn
EOF
sudo systemctl stop firewalld
hdfs namenode -format
