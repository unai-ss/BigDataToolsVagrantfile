sudo wget https://archive.cloudera.com/cm6/6.0.0/redhat7/yum/ -P /etc/yum.repos.d/
sudo rpm --import https://archive.cloudera.com/cm6/6.0.0/redhat7/yum/RPM-GPG-KEY-cloudera
sudo yum update
sudo systemctl stop firewalld
