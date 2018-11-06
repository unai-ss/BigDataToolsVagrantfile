sudo yum install -y git
wget http://ftp.cixug.es/apache/maven/maven-3/3.6.0/source/apache-maven-3.6.0-src.tar.gz
tar -zxvf apache-maven-3.6.0-src.tar.gz
export PATH=/opt/apache-maven-3.6.0/bin:$PATH
git clone https://github.com/locationtech/geomesa/ && cd geomesa && build/mvn clean install -DskipTests
build/mvn clean install -DskipTests
