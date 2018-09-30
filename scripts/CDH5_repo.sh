sudo curl "https://archive.cloudera.com/cdh5/redhat/7/x86_64/cdh/cloudera-cdh5.repo" -O /etc/yum.repos.d/
sudo yum update
sudo systemctl stop firewalld
