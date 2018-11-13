apache-maven-3.6.0-bin.tar.gz

wget http://ftp.cixug.es/apache/maven/maven-3/3.6.0/binaries/apache-maven-3.6.0-bin.tar.gz
tar -zxvf apache-maven-3.6.0-bin.tar.gz
sudo sh -c "echo MAVEN_HOME:~/apache-maven-3.6.0 >> ~/.bashrc"
sudo sh -c "echo PATH=$PATH:~/apache-maven-3.6.0/bin >> ~/.bashrc"
source ~/.bashrc
