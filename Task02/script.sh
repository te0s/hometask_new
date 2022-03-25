#!/bin/bash

yes | apt-get install mc
yes | apt-get install lxc lxc-templates

# cat <<PAST | tee -a /etc/lxc/lxc-usernet
# your-username veth lxcbr0 10
# PAST

cat <<PAST | tee -a /etc/default/lxc-net
USE_LXC_BRIDGE="true"
LXC_BRIDGE="lxcbr0"
LXC_ADDR="10.0.3.1"
LXC_NETMASK="255.255.255.0"
LXC_NETWORK="10.0.3.0/24"
LXC_DHCP_RANGE="10.0.3.2,10.0.3.254"
LXC_DHCP_MAX="253"
LXC_DHCP_CONFILE=/etc/lxc/dnsmasq.conf
LXC_DOMAIN=""
PAST

cat <<PAST | tee /etc/lxc/dnsmasq.conf
# dhcp-host=centos1,10.0.3.100
# dhcp-host=centos2,10.0.3.101
dhcp-hostsfile=/etc/lxc/dnsmasq-hosts.conf
PAST

cat <<PAST | tee /etc/lxc/dnsmasq-hosts.conf
centos1,10.0.3.100
centos2,10.0.3.101
PAST

sudo mkdir -p /var/lib/lxd/networks/lxcbr0/
cat <<PAST | tee /var/lib/lxd/networks/lxcbr0/dnsmasq.hosts
10.0.3.100,centos1
10.0.3.101,centos2
PAST

sudo mkdir -p /etc/dnsmasq.d-available/
cat <<PAST | tee /etc/dnsmasq.d-available/lxc
bind-interfaces
except-interface=lxcbr0
PAST

sudo systemctl enable lxc-net
sudo systemctl start lxc-net

cat <<PAST | tee /etc/lxc/default.conf
lxc.net.0.type  = veth
lxc.net.0.flags = up
lxc.net.0.link  = lxcbr0
lxc.apparmor.profile = unconfined
PAST

sudo lxc-create -n centos1 -t download -- --dist centos --release 8-Stream --arch amd64 --keyserver hkp://keyserver.ubuntu.com
sudo lxc-create -n centos2 -t download -- --dist centos --release 8-Stream --arch amd64 --keyserver hkp://keyserver.ubuntu.com


sudo lxc-start -n centos1
sudo lxc-start -n centos2

sleep 10

sudo lxc-attach centos1 -- yum -y install httpd
sudo lxc-attach centos1 -- systemctl enable httpd
sudo lxc-attach centos1 -- systemctl start httpd


sudo lxc-attach centos2 -- yum -y install httpd
sudo lxc-attach centos2 -- yum -y install php
sudo lxc-attach centos2 -- systemctl enable httpd
sudo lxc-attach centos2 -- systemctl start httpd

sudo mv /home/vagrant/sites/01-demosite-static /var/lib/lxc/centos1/rootfs/var/www/html/01-demosite-static
cat <<PAST | sudo tee /var/lib/lxc/centos1/rootfs/etc/httpd/conf.d/01-demosite-static.conf
<VirtualHost *:80>
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/html/01-demosite-static
        DirectoryIndex index.html
</VirtualHost>
PAST

sudo mv /home/vagrant/sites/01-demosite-php /var/lib/lxc/centos2/rootfs/var/www/html/01-demosite-php
cat <<PAST | sudo tee /var/lib/lxc/centos2/rootfs/etc/httpd/conf.d/01-demosite-php.conf
<VirtualHost *:81>
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/html/01-demosite-php
        DirectoryIndex index.php
</VirtualHost>
PAST

sudo sed -i.bak -e "/Listen 80/a Listen 81" /var/lib/lxc/centos2/rootfs/etc/httpd/conf/httpd.conf

sudo rm /var/lib/lxc/centos1/rootfs/etc/httpd/conf.d/welcome.conf
sudo rm /var/lib/lxc/centos2/rootfs/etc/httpd/conf.d/welcome.conf

sudo lxc-attach centos1 -- systemctl restart httpd
sudo lxc-attach centos2 -- systemctl restart httpd

CENTOS1IP=$(sudo lxc-info -i -n centos1 | cut -d : -f 2)
CENTOS2IP=$(sudo lxc-info -i -n centos2 | cut -d : -f 2)
sudo iptables -F
# sudo iptables -t nat -I PREROUTING -i eth0 -p tcp --dport 80 -j DNAT --to-destination 10.0.3.14:80
sudo iptables -t nat -I PREROUTING -i eth0 -p tcp --dport 80 -j DNAT --to-destination ${CENTOS1IP}:80
sudo iptables -t nat -I PREROUTING -i eth0 -p tcp --dport 81 -j DNAT --to-destination ${CENTOS2IP}:81

sudo lxc-ls -f