#https://www.digitalocean.com/community/tutorials/how-to-set-up-centralized-linux-authentication-with-freeipa-on-centos-7
 sudo yum install lsof vim dnsmaq -y
cat <<EOF> /etc/dnsmasq.conf
server=8.8.8.8
server=8.8.4.4
listen-address= 10.0.2.15
domain=external.acc
address=/masterlb.external.acc/172.16.1.2
address=/agent.external.acc/172.16.1.3
address=/bootstrap.external.acc/172.16.1.1
address=/ansible.external.acc/172.16.1.4
address=/freeipa.external.acc/10.0.2.15s
ptr-record=2.1.16.172.in-addr.arpa,masterlb.external.acc
ptr-record=4.1.16.172.in-addr.arpa,ansible.external.acc
ptr-record=3.1.16.172.in-addr.arpa,agent.external.acc
ptr-record=4.1.16.172.in-addr.arpa,bootstrap.external.acc
ptr-record=15.2.0.10.in-addr.arpa,freeipa.external.acc
EOF
sudo hostnamectl set-hostname freeipa.external.acc
sed -i '/PEERDNS=yes/PEERDNS=no/g' /etc/sysconfig/network-scripts/ifcfg-enp0s3
cat <<EOF>> /etc/sysconfig/network-scripts/ifcfg-enp0s3
DNS1=10.0.2.15
EOF
sed -i '/freeipa/d' /etc/hosts
cat <<EOF>> /etc/hosts
10.0.2.15 freeipa freeipa.external.acc
EOF
#sudo yum update
sudo firewall-cmd --permanent --add-port={80/tcp,443/tcp,389/tcp,636/tcp,88/tcp,464/tcp,53/tcp,88/udp,464/udp,53/udp,123/udp}
sudo firewall-cmd --reload
sudo yum install rng-tools -y
sudo systemctl start rngd
sudo systemctl enable rngd
sudo systemctl status rngd
sudo yum install ipa-server ipa-server-dns -y
sudo chown 0777 /var/log/ipaserver-install.log
#sudo ipa-server-install -p Passwd123 -a Passwd123 -n EXAMPLE.COM -r EXAMPLE.COM
sudo ipa-server-install
