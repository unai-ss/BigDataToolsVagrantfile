sudo echo 'INSTALLER: Started up'

# get up to date
#yum upgrade -y

#echo 'INSTALLER: System updated'

# fix locale warning
sudo echo LANG=en_US.utf-8 >> /etc/environment
sudo echo LC_ALL=en_US.utf-8 >> /etc/environment

sudo echo 'INSTALLER: Locale set'
sudo echo 'disable security'
sudo systemctl stop firewalld && sudo systemctl disable firewalld
sudo systemctl stop selinux && systemctl disable selinux

sudo echo 'INSTALLER:scala'
sudo curl  http://downloads.lightbend.com/scala/2.12.2/scala-2.12.2.rpm -o /home/vagrant/scala-2.12.2.rpm
sudo yum  localinstall /home/vagrant/scala-2.12.2.rpm -y
sudo scala -version

sudo echo 'INSTALLER:SPARK HADOOP'
sudo curl http://www-eu.apache.org/dist/spark/spark-2.2.2/spark-2.2.2-bin-hadoop2.7.tgz -o /opt/spark-2.2.2-bin-hadoop2.7.tgz
sudo tar -C /opt -xvzf /opt/spark-2.2.2-bin-hadoop2.7.tgz
sudo ln -s /opt/spark-2.2.2-bin-hadoop2.7  /opt/spark
sudo mkdir -p /usr/local/spark
sudo cp -r /opt/spark-2.2.2-bin-hadoop2.7/* /usr/local/spark
export PATH=$PATH:$HOME/bin:/opt/spark/bin
export SPARK_EXAMPLES_JAR=/opt/spark/examples/jars/spark-examples_2.11-2.2.2.jar
sudo sh -c "echo SPARK_EXAMPLES_JAR=/opt/spark/examples/jars/spark-examples_2.11-2.2.2.jar >> /etc/environment"
sudo sh -c "echo PATH=$PATH:$HOME/bin:/opt/spark/bin >> /etc/environment"
