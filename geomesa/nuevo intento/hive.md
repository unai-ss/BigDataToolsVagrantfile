https://www.edureka.co/blog/apache-hive-installation-on-ubuntu
wget http://archive.apache.org/dist/hive/hive-2.1.0/apache-hive-2.1.0-bin.tar.gz
tar -xzf apache-hive-2.1.0-bin.tar.gz
ls
```
.bashrc
Set HIVE_HOME

export HIVE_HOME=/home/edureka/apache-hive-2.1.0-bin
export PATH=$PATH:/home/edureka/apache-hive-2.1.0-bin/bin
```
hdfs dfs -mkdir -p /user/hive/warehouse
hdfs dfs -mkdir /tmp
hdfs dfs -chmod g+w /user/hive/warehouse
hdfs dfs -chmod g+w /tmp


Set Hadoop path in hive-env.sh
export HADOOP_HOME=/home/vagrant/hadoop
export HADOOP_HEAPSIZE=512
export HIVE_CONF_DIR=/home/vagrant/hive/conf

hive/conf/hive-site.examples
```
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?><!--
Licensed to the Apache Software Foundation (ASF) under one or more
contributor license agreements. See the NOTICE file distributed with
this work for additional information regarding copyright ownership.
The ASF licenses this file to You under the Apache License, Version 2.0
(the "License"); you may not use this file except in compliance with
the License. You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
-->
<configuration>
<property>
<name>javax.jdo.option.ConnectionURL</name>
<value>jdbc:derby:;databaseName=/home/edureka/apache-hive-2.1.0-bin/metastore_db;create=true</value>
<description>
JDBC connect string for a JDBC metastore.
To use SSL to encrypt/authenticate the connection, provide database-specific SSL flag in the connection URL.
For example, jdbc:postgresql://myhost/db?ssl=true for postgres database.
</description>
</property>
<property>
<name>hive.metastore.warehouse.dir</name>
<value>/user/hive/warehouse</value>
<description>location of default database for the warehouse</description>
</property>
<property>
<name>hive.metastore.uris</name>
<value/>
<description>Thrift URI for the remote metastore. Used by metastore client to connect to remote metastore.</description>
</property>
<property>
<name>javax.jdo.option.ConnectionDriverName</name>
<value>org.apache.derby.jdbc.EmbeddedDriver</value>
<description>Driver class name for a JDBC metastore</description>
</property>
<property>
<name>javax.jdo.PersistenceManagerFactoryClass</name>
<value>org.datanucleus.api.jdo.JDOPersistenceManagerFactory</value>
<description>class implementing the jdo persistence</description>
</property>
</configuration>
```

bin/schematool -initSchema -dbType derby

hives

https://community.hortonworks.com/questions/90465/connect-hive-with-zookeeper-in-java.html
hive jdbc:hive2://127.0.0.1:2181;serviceDiscoveryMode=zooKeeper;zooKeeperNamespace=hiveserver2



CREATE EXTERNAL TABLE weather6 (col1 INT, col2 STRING) COMMENT 'Employee details' ROW FORMAT DELIMITED FIELDS TERMINATED BY ' ' STORED AS TEXTFILE LOCATION '/data1';


$ cat /tmp/sample.txt
1 a
2 b
3 c

$ hdfs dfs -mkdir  /data1
$ hdfs dfs -chown hive:hive /data1
$ hdfs dfs -cp /tmp/sample.txt /data1

$ hive
hive> CREATE EXTERNAL TABLE weather6 (col1 INT, col2 STRING)
    > COMMENT 'Employee details'
    > ROW FORMAT DELIMITED FIELDS TERMINATED BY ' '
    > STORED AS TEXTFILE
    > LOCATION '/data1';

hive> select * from weather6;
OK
1	a
2	b
3	c



ime taken: 2.289 seconds, Fetched: 3 row(s)
hive> CREATE TABLE IF NOT EXISTS pagecounts_hbase (rowkey STRING, pageviews STRING, bytes STRING)
    > STORED BY 'org.apache.hadoop.hive.hbase.HBaseStorageHandler'
    > WITH SERDEPROPERTIES ('hbase.columns.mapping' = ':key,f:c1,f:c2')
    > TBLPROPERTIES ('hbase.table.name' = 'pagecounts');


    http://www.n10k.com/blog/hbase-via-hive-pt2/

    https://impala.apache.org/docs/build/html/topics/impala_hbase.html
