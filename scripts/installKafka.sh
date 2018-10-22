#!/bin/bash
#

echo 'INSTALLER: Started up'

# get up to date
#yum upgrade -y

echo 'INSTALLER: System updated'

# fix locale warning
echo LANG=en_US.utf-8 >> /etc/environment
echo LC_ALL=en_US.utf-8 >> /etc/environment

echo 'INSTALLER: Locale set'
echo 'INSTALLER: Going to reboot to get updated system'
#sudo wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u181-b13/96a7b8442fe848ef90c96a2fad6ed6d1/jdk-8u181-linux-x64.rpm"
#sudo wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u181-b13/96a7b8442fe848ef90c96a2fad6ed6d1/jre-8u181-linux-x64.rpm"
#echo 'Instalar Java 8 JRE y JDK'
#sudo yum localinstall jdk-8u181-linux-x64.rpm -y
#sudo yum localinstall jre-8u181-linux-x64.rpm -y
#sudo export JAVA_HOME=/opt/jdk1.8.0_181
#sudo export JRE_HOME=/opt/jdk1.8.0_181/jre
#sudo export PATH=$PATH:/opt/jdk1.8.0_181/bin:/opt/jdk1.8.0_181/jre/bin
#sudo sh -c "echo JAVA_HOME=/usr/java/jdk1.8.0_181-amd64 >> /etc/environment"
#sudo sh -c "echo JRE_HOME=/usr/java/jdk1.8.0_181-amd64/jre >> /etc/environment"
#sudo sh -c "echo PATH=$PATH:/usr/java/jdk1.8.0_181-amd64/bin:/opt/jdk1.8.0_181-amd64/jre/bin >> /etc/environment"
#sudo useradd vagrant -m

echo 'Inicio Instalación Kafka'
sudo usermod -aG wheel vagrant
sudo mkdir /home/vagrant/Downloads
sudo curl "http://www-eu.apache.org/dist/kafka/1.1.0/kafka_2.12-1.1.0.tgz" -o /home/vagrant/Downloads/kafka.tgz
sudo mkdir /home/vagrant/kafka && sudo cd /home/vagrant/kafka
sudo tar -C /home/vagrant/kafka -xvzf /home/vagrant/Downloads/kafka.tgz --strip 1
sudo touch /var/log/kafka.log && sudo chmod 666 /var/log/kafka.log
#sudo cp /tmp/sync/scripts/kafka.service /etc/systemd/system/kafka.service
sudo cat <<EOF >/etc/systemd/system/kafka.service
[Unit]
Requires=zookeeper.service
After=zookeeper.service

[Service]
Type=simple
User=vagrant
ExecStart=/bin/sh -c '/home/vagrant/kafka/bin/kafka-server-start.sh /home/vagrant/kafka/config/server.properties > /var/log/kafka.log 2>&1'
ExecStop=/home/vagrant/kafka/bin/kafka-server-stop.sh
Restart=on-abnormal

[Install]
WantedBy=multi-user.target
EOF
#sudo cp /tmp/sync/scripts/zookeeper.service /etc/systemd/system/zookeeper.service
sudo cat <<EOF >/etc/systemd/system/zookeeper.service
[Unit]
Requires=network.target remote-fs.target
After=network.target remote-fs.target

[Service]
Type=simple
User=vagrant
ExecStart=/home/vagrant/kafka/bin/zookeeper-server-start.sh /home/vagrant/kafka/config/zookeeper.properties
ExecStop=/home/vagrant/kafka/bin/zookeeper-server-stop.sh
Restart=on-abnormal

[Install]
WantedBy=multi-user.target
EOF
sudo echo -e '\ndelete.topic.enable = true' >> /home/vagrant/kafka/config/server.properties
sudo systemctl daemon-reload
sudo systemctl start kafka
sudo systemctl enable kafka

echo 'INSTALLER KAFKAT'
sudo yum install ruby ruby-devel make gcc patch -y
sudo gem install kafkat
sudo cat <<EOF >/home/vagrant/.kafkatcfg
{
  "kafka_path": "~/kafka",
  "log_path": "/tmp/kafka-logs",
  "zk_path": "localhost:2181"
}
EOF

echo 'test kafka'
/home/vagrant/kafka/bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic TopicF3
/home/vagrant/kafka/bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic TopicS2
/home/vagrant/kafka/bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic TopicG1
#echo "Hello, World" | /home/vagrant/kafka/bin/kafka-console-producer.sh --broker-list localhost:9092 --topic TutorialTopic > /dev/null
#/home/vagrant/kafka/bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic TutorialTopic --from-beginning
sudo /usr/local/bin/kafkat partitions
echo 'fin de pruebas de kafka'
