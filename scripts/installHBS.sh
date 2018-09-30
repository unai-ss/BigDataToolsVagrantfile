sudo curl "https://archive.cloudera.com/cdh5/redhat/7/x86_64/cdh/cloudera-cdh5.repo" -O /etc/yum.repos.d/
sudo yum update
sudo yum install hbase-master -y
sudo service hbase-master start
sudo systemctl enable hbase-master
curl http://localhost:60010
sudo systemctl stop firewalld
