sudo dnf -y update
sudo dnf -y nano vim mc wget net-tools lsof telnet psmisc


# Install Apache
sudo dnf -y install httpd
sudo chmod 775 /var/www/html
sudo chown -R root:vagrant /var/www/html
sudo systemctl enable httpd
sudo systemctl start httpd

# Install PHP
sudo dnf -y install php php-opcache php-gd php-mysqlnd php-json php-xml php-xmlrpc php-pear php-ldap php-odbc php-mbstring php-snmp php-soap php-zip
sudo systemctl restart httpd

# Install MariaDB
sudo dnf -y install mariadb-server mariadb

sudo systemctl enable mariadb.service
sudo systemctl start mariadb.service