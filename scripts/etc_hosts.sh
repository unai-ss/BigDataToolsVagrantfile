cat <<EOF >>/etc/hosts
192.168.1.206   hbase
192.168.1.207   kafka
192.168.1.208   spark
192.168.1.209   hdpnn
192.168.1.210   hdpdn1
192.168.1.211   hdpdn2
EOF

ssh-keygen -t rsa
ssh-copy-id -i .ssh/id_rsa vagrant@hdpdn1
ssh-copy-id -i .ssh/id_rsa vagrant@hdpdn2


cat <<EOF >/home/vagrant/.ssh/id_rsa
-----BEGIN RSA PRIVATE KEY-----
MIIEowIBAAKCAQEA7Uy6fUnEigfoH33Ru0+GX/fSkgRfc2PPHIVxOps4wb1TESwb
b4Rc4K/4ePXgPyesqweewATwAT3F4KEOiBe0khQiF/y0qzXQ1vElQf+AiUh8r9Z5
4xFyIgz5FLT9dEjAbqZq+OMXh/KidM6d0Zqe5vN0l902Z0mNZSyYNvJUHlDTM0dO
qPqxBVXssGinxlIOGZ7XMmT9vSUM+wKAG+SAf/AN9oyyodYPiWp676CQC2DK3AoX
O8Px2CwggbMYoPAx9eTAQh3GcTfbUDTi8b3iEBd7tjpXtEEyuESh2wjTusP3tbS/
S4SY0+sBsaCr+rNV1h9iOyXhvg+K87vSGunfGQIDAQABAoIBAFHLhuS0zrg9bXed
aPPFv63IwJ5wP26I0tUj8hmfc3rkhYN/zp0r5M/WGDGpnvhl9pClecT6brge0NxS
561lbmqD4hSemLADRs8wJAWRyn6Hq+L4bN8mHk86ZYkLsempQhth5bGQpYXIztKw
fZnIUEmPVXsbVytXIRPkwTr/YJtp2tPnxKsyPehT29j2jyi/DCpH2BVe8tYTXCxW
/UFlXXjWV2JSyXLo/3yW5TCqujHjwEp7S0HkzX7J8cCDyzxH+wUwTc79TTZ1/oCA
pSV+xl2OqQHgvTJCJuqWv+1bEXbnPoqXdjdt7JtIykZp5tXURkG0K7g410qd9kJS
xbPXhjkCgYEA+gbxOxeJYibd348mYkRBjW6H8HvXh4bNKC1BbWI/7/7W4lvF1Dxz
tboG3vWKo8yWyCuGW9kIc49JKhnH5vHYqZ2HIzmabacpdA5dm+K/ysUgVa6EBvpK
3Eh0Ea/rbbMhafWdHYylm2dMl3ODGO+YvCrXcC0pcRuh+FaSoJG2TlMCgYEA8vfz
bquK0PWFlIsZbZCXHyvqp7x6pcY3xlhzPxlCTWQoSQnsbVMFQvf0do/myvGMOVT5
y99MSJigxl+yTtpSoL31GCJiQPiec1T60fKMipup2tg1nKR7uttF01LEYlvCUEMp
0pQOM1SUBE4R0d+evFLtrYL0CWy4fjCJ/rbbd2MCgYBNyvEtqKIXRu6Ly3du5bvb
rINhYLbrtRaKJKKRzRsFqi3j2hgQdAqwhUP0BUPwuQxFFb3FQB7wDan/DmxzP9Zg
1+GfJSIWcgdk079ubDuudG0eG6F6pk+6gFSU2D6RMEX6OPB8rDEuzBI5oTgt/wZv
rYjAn1ygk69unEkc6pllfwKBgQDxWxm44DMfbCXr71mtGyrjzi5lvbdgIc2Z/JdP
IPpaApp6I5924jeh1MpFVKGBC/2tnhoeSY1vuB5NsRZhekMGZmyoMs/DlrVgABTA
pd6yeft657gqCMLYVaXBTMDErD4UmQNcqbKJjwUSWbMd9rOqg/6SlDlze0qyH+mU
23Sb3QKBgB9wHDUcA6rzQU02EnFLZQz4aKm45w/IyYq8Q9D9DK/pKMViqaDBPzKC
sM9v9eKpxZh3VG9ZzEsfZL1zcbDwOfSI4CRZvGPNCLl0MhJ1Sa63R9FEGcXeHAmJ
BTOuz5AGbzKdZ6WP5QuegEe8N+acUYZuiyWjUPOcbMiG/z6f0hDO
-----END RSA PRIVATE KEY-----
EOF

cat <<EOF >>/home/vagrant/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDtTLp9ScSKB+gffdG7T4Zf99KSBF9zY88chXE6mzjBvVMRLBtvhFzgr/h49eA/J6yrB57ABPABPcXgoQ6IF7SSFCIX/LSrNdDW8SVB/4CJSHyv1nnjEXIiDPkUtP10SMBupmr44xeH8qJ0zp3Rmp7m83SX3TZnSY1lLJg28lQeUNMzR06o+rEFVeywaKfGUg4ZntcyZP29JQz7AoAb5IB/8A32jLKh1g+JanrvoJALYMrcChc7w/HYLCCBsxig8DH15MBCHcZxN9tQNOLxveIQF3u2Ole0QTK4RKHbCNO6w/e1tL9LhJjT6wGxoKv6s1XWH2I7JeG+D4rzu9Ia6d8Z vagrant@hdpnn
EOF

sudo mkdir -p $(dirname /home/vagrant/hadoop-2.9.1/logs/hadoop-vagrant-datanode-hdpnn.out
sudo touch /home/vagrant/hadoop-2.9.1/logs/hadoop-vagrant-datanode-hdpnn.out

sudo mkdir -p $(dirname /home/vagrant/hadoop-2.9.1/logs/hadoop-vagrant-datanode-hdpdn1.out
sudo touch /home/vagrant/hadoop-2.9.1/logs/hadoop-vagrant-datanode-hdpdn1.out
sudo chown -R vagrant:vagrant /home/vagrant

sudo mkdir -p $(dirname /home/vagrant/hadoop-2.9.1/logs/hadoop-vagrant-datanode-hdpdn2.out
sudo touch /home/vagrant/hadoop-2.9.1/logs/hadoop-vagrant-datanode-hdpdn2.out
sudo chown -R vagrant:vagrant /home/vagrant

hdfs namenode -format

#testear esta parte
su -i hduser
ssh-keygen -t rsa -P 
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
ssh-copy-id -i ~/.ssh/id_rsa.pub
ssh-copy-id -i ~/.ssh/id_rsa.pub hduser@hddatanode1
ssh-copy-id -i ~/.ssh/id_rsa.pub hduser@hddatanode2
ssh-copy-id -i ~/.ssh/id_rsa.pub hduser@hddatanode3

useradd hadoop
passwd hadoop

su - hadoop
ssh-keygen -t rsa
ssh-copy-id -i .ssh/id_rsa vagrant@hdpdn1
ssh-copy-id -i .ssh/id_rsa vagrant@hdpdn2
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 0600 ~/.ssh/authorized_keys
exit
