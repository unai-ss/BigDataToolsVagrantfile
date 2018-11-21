hadoop namenode --upgrade

```
[vagrant@hbaseDistr geomesa]$ hadoop version
Hadoop 2.6.4
Subversion https://git-wip-us.apache.org/repos/asf/hadoop.git -r 5082c73637530b0b7e115f9625ed7fac69f937e6
Compiled by jenkins on 2016-02-12T09:45Z
Compiled with protoc 2.5.0
From source with checksum 8dee2286ecdbbbc930a6c87b65cbc010
This command was run using /home/vagrant/hadoop-2.6.4/share/hadoop/common/hadoop-common-2.6.4.jar
```
```
[vagrant@hbaseDistr geomesa]$ hbase version
HBase 1.3.1
Source code repository git://mantonov-mbp1/Users/mantonov/hbase revision=930b9a55528fe45d8edce7af42fef2d35e77677a
Compiled by mantonov on Thu Apr  6 19:36:54 PDT 2017
From source with checksum a34b810bed77b3a56af797405bea7c78
```

## GEOMESA INSTALL.

```
[vagrant@hbaseDistr geomesa-git]$git branch
* master
```
### Download
```
yum install git -y
git clone https://github.com/locationtech/geomesa.git
cd geomesa
cp -r build/ geomesa-hbase/
cp -r docs/ geomesa-hbase/
cd geomesa-hbase/
mvn clean install -pl geomesa-hbase-dist -am
cp ./geomesa-hbase-dist/target/geomesa-hbase_2.11-2.2.0-SNAPSHOT-bin.tar.gz /tmp/
cd /tmp/
tar -zxvf geomesa-hbase_2.11-2.2.0-SNAPSHOT-bin.tar.gz
cp -r geomesa-hbase_2.11-2.2.0-SNAPSHOT /home/vagrant/
ln -s /home/vagrant/geomesa-hbase_2.11-2.2.0-SNAPSHOT geomesa-hbase
```
### mas descargas maven
```
geomesa/bin/install-jai.sh ((lib) puede que agregar parametro lib)
geomesa/bin/install-jline.sh ((lib) puede que agregar parametro lib)
geomesa/bin/install-hadoop.sh
geomesa/bin/install-hbase.sh
```

```
cd geomesa/dist/hbase/
hadoop dfs -put geomesa-hbase-distributed-runtime_2.11-2.1.0-SNAPSHOT.jar /hbase/lib
cp geomesa-hbase-distributed-runtime_2.11-2.1.0-SNAPSHOT.jar $HBASE_HOME/lib (un poco loco)
```

### test geomesa-hbase classpath
```
geomesa-hbase classpath | grep geomesa-hbase-distributed-runtime_2.11-2.1.0-SNAPSHOT.jar
```
### Error YarnProto
```
[vagrant@hbaseDistr hbase]$ geomesa-hbase ingest --catalog t4ble2 --feature-name gdelt --converter gdelt2 --spec gdelt2 hdfs://localhost:54310/gdelt/uncompressed/20181101.tsv
INFO  Schema 'gdelt' exists
INFO  Running ingestion in distributed mode
INFO  Submitting job - please wait...
Exception in thread "main" java.lang.NoSuchMethodError: org.apache.hadoop.yarn.proto.YarnProtos$LocalResourceProto.hashLong(J)I
	at org.apache.hadoop.yarn.proto.YarnProtos$LocalResourceProto.hashCode(YarnProtos.java:11555)
	at org.apache.hadoop.yarn.api.records.impl.pb.LocalResourcePBImpl.hashCode(LocalResourcePBImpl.java:62)
	at java.util.HashMap.hash(HashMap.java:339)
	at java.util.HashMap.put(HashMap.java:612)
```
sustituyo version 2.5 por la 2.6 que ha descargado maven
```
[vagrant@hbaseDistr geomesa]$ cp /home/vagrant/hadoop/share/hadoop/yarn/lib/protobuf-java-2.5.0.jar /home/vagrant/geomesa/lib/
[vagrant@hbaseDistr geomesa]$ cp /home/vagrant/hadoop/share/hadoop/yarn/lib/protobuf-java-2.5.0.jar /home/vagrant/geomesa/lib/
[vagrant@hbaseDistr geomesa]$ cp /home/vagrant/geomesa/lib/protobuf-java-2.6.1.jar ~/
[vagrant@hbaseDistr geomesa]$ rm /home/vagrant/geomesa/lib/protobuf-java-2.6.1.jar
```
## INGESTA de Datos

[https://www.geomesa.org/documentation/tutorials/geomesa-examples-gdelt.html](https://www.geomesa.org/documentation/tutorials/geomesa-examples-gdelt.html)

## descargamos ejemplo
```
wget http://data.gdeltproject.org/gdeltv2/20181101081500.export.CSV.zip
ls 20181101081500.export.CSV.zip | xargs -n 1 zcat | hadoop fs -put - /gdelt/uncompressed/20181101.tsv
```
Test
```
vagrant@hbaseDistr geomesa]$ geomesa-hbase ingest --catalog t4ble2 --feature-name gdelt --converter gdelt2 --spec gdelt2 hdfs://localhost:54310/gdelt/uncompressed/20181101.tsv
INFO  Schema 'gdelt' exists
INFO  Running ingestion in distributed mode
INFO  Submitting job - please wait...
INFO  Tracking available at http://localhost:8080/
[============================================================] 100% complete 1628 ingested 52 failed in 00:00:20
INFO  Distributed ingestion complete in 00:00:20
INFO  Ingested 1628 features and failed to ingest 52 features.
```
