sudo yum install -y git
wget http://apache.uvigo.es/maven/maven-3/3.6.0/binaries/apache-maven-3.6.0-bin.tar.gz
tar -zxvf apache-maven-3.6.0-bin.tar.gz
export PATH=/home/vagrant/apache-maven-3.6.0/bin:$PATH
git clone https://github.com/locationtech/geomesa/
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
export PATH=$PATH:/home/vagrant/geomesa-hbase/bin
hdfs dfs -mkdir /hbase/lib
hdfs dfs -put geomesa-hbase/dist/hbase/geomesa-hbase-distributed-runtime_2.11-2.1.0.jar /hbase/lib
##no do# cp geomesa-hbase-distributed-runtime_2.11-2.1.0.jar ~/hbase/lib/
export GEOMESA_HBASE_HOME=/home/vagrant/geomesa-hbase
export GEOMESA_HADOOP_CLASSPATH=$(hadoop classpath)
export GEOMESA_HADOOP_CLASSPATH=$(~/hadoop-2.6.4/bin/hadoop classpath)
export GEOMESA_HBASE_CLASSPATH=$(hbase classpath)
export GEOMESA_HBASE_CLASSPATH=$(~/hbase-1.3.1/bin/hbase classpath)
Me llevo la sensacion que el punto es descargar las version de hbase y hadoop
del pom.xml, para que unica y exclusivamente este en el geomesa classpath
cd /home/vagrant/geomesa-hbase/bin
./install-jai.sh
./install-jline.sh
cp ~/hbase/conf/hbase-site.xml ~/geomesa-hbase/
zip -r lib/geomesa-hbase-datastore_2.11-$VERSION.jar hbase-site.xml
wget http://data.gdeltproject.org/gdeltv2/20181109080000.export.CSV.zip
ls 20181109080000.export.CSV.zip | xargs -n 1 zcat > 2018A.tsv
geomesa-hbase ingest --catalog lb_table --feature-name gdelt --converter gdelt2 --spec gdelt2 2018011.tsv
