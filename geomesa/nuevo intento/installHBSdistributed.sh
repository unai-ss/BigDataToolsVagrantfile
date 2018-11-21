# hbase 1.2 standalone
sudo yum install gcc gcc-c++ make ssh rsync lsof vim -y
sudo wget https://archive.apache.org/dist/hbase/1.3.1/hbase-1.3.1-bin.tar.gz
sudo wget https://apache.org/dist/zookeeper/zookeeper-3.4.10/zookeeper-3.4.10.tar.gz
sudo tar -zxvf zookeeper-3.4.10.tar.gz
sudo tar -C /home/vagrant/ -zxvf hbase-1.3.1-bin.tar.gz
ln -s /home/vagrant/hbase-1.3.1 hbase
ln -s /home/vagrant/zookeeper-3.4.10 zookeeper
cp /home/vagrant/zookeeper/conf/zoo_sample.cfg /home/vagrant/zookeeper/conf/zoo.cfg
sudo chown -R vagrant:vagrant zookeeper-3.4.10

sh -c "echo HADOOP_MAPRED_HOME=$HADOOP_HOME >> ~/.bashrc"
sh -c "echo HADOOP_COMMON_HOME=$HADOOP_HOME >> ~/.bashrc"
sh -c "echo YARN_HOME=$HADOOP_HOME >> ~/.bashrc"
sh -c "echo HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native >> ~/.bashrc"
sh -c "echo HADOOP_OPTS=-Djava.library.path=$HADOOP_HOME/lib>> ~/.bashrc"
sh -c "echo PATH=$PATH:~/hbase/bin>> ~/.bashrc"
sh -c "echo HBASE_HOME=/home/vagrant/hbase>> ~/.bashrc"

# sh -c "echo HBASE_REGIONSERVERS=${HBASE_HOME}/conf/regionservers>> ~/.bashrc"
# sh -c "echo HBASE_MANAGES_ZK=true>> ~/.bashrc"
sh -c "echo HBASE_DISABLE_HADOOP_CLASSPATH_LOOKUP=true>> ~/.bashrc"
source ~/.bashrc
sudo chown -R vagrant:vagrant hbase-1.3.1

cat <<EOF > /home/vagrant/hbase-1.3.1/conf/hbase-site.xml
<?xml version="1.0"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<!--
/**
 *
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
-->
<configuration>
  <property>
    <name>hbase.rootdir</name>
    <value>hdfs://localhost:54310/hbase</value>
  </property>

  <property>
    <name>hbase.cluster.distributed</name>
    <value>true</value>
  </property>

  <property>
    <name>hbase.zookeeper.property.clientPort</name>
    <value>2181</value>
  </property>

  <property>
    <name>hbase.zookeeper.property.dataDir</name>
    <value>/home/vagrant/zookeeper</value>
  </property>
  <property>
    <name>zookeeper.znode.parent</name>
    <value>/hbase</value>
  </property>
<property>
    <name>hbase.coprocessor.user.region.classes</name>
    <value>org.locationtech.geomesa.hbase.coprocessor.GeoMesaCoprocessor</value>
  </property>

  <property>
    <name>hbase.dynamic.jars.dir</name>
    <value>hdfs://localhost:54310/hbase/lib</value>
  </property>
<!--
 <property>
    <name>geomesa.hbase.remote.filtering</name>
    <value>false</value>
  </property>
-->
</configuration>
EOF
