cat <<EOF >>/etc/hosts
192.168.1.206   hbase
192.168.1.207   kafka
192.168.1.208   spark
192.168.1.209   hdpnn
192.168.1.210   hdpdn1
192.168.1.211   hdpdn2
EOF

#testear esta parte
hduser@hdnamenode:~$ su -i hduser
hduser@hdnamenode:~$ ssh-keygen -t rsa -P 
hduser@hdnamenode:~$cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
hduser@hdnamenode:~$ ssh-copy-id -i ~/.ssh/id_rsa.pub
hduser@hdnamenode:~$ ssh-copy-id -i ~/.ssh/id_rsa.pub hduser@hddatanode1
hduser@hdnamenode:~$ ssh-copy-id -i ~/.ssh/id_rsa.pub hduser@hddatanode2
hduser@hdnamenode:~$ ssh-copy-id -i ~/.ssh/id_rsa.pub hduser@hddatanode3

useradd hadoop
passwd hadoop

su - hadoop
ssh-keygen -t rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 0600 ~/.ssh/authorized_keys
exit
