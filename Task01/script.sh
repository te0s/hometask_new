#!/bin/bash


sudo yum update -y
sudo yum install -y httpd
sudo yum install -y mysql-server
sudo yum install -y php
sudo yum install -y mc


sudo systemctl enable httpd
sudo systemctl start httpd
sudo systemctl start mysqld

sudo rm /etc/httpd/sites-available/01-demosite-static.conf
sudo touch /etc/httpd/sites-available/01-demosite-static.conf
sudo cat <<PAST | tee -a /etc/httpd/sites-available/01-demosite-static.conf
<VirtualHost *:80>
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/html/01-demosite-static
        DirectoryIndex index.html
        ErrorLog \${APACHE_LOG_DIR}/error.log
        CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
PAST

sudo rm /etc/httpd/sites-available/01-demosite-php.conf
sudo touch /etc/httpd/sites-available/01-demosite-php.conf
sudo cat <<PAST | tee -a /etc/httpd/sites-available/01-demosite-php.conf
<VirtualHost *:81>
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/html/01-demosite-php
        DirectoryIndex index.php
        ErrorLog \${APACHE_LOG_DIR}/error.log
        CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
PAST

sudo sudo a2ensite 01-demosite-static.conf
sudo a2ensite 01-demosite-php.conf
sudo rm /etc/httpd/sites-enabled/000-default.conf

sudo cp /etc/httpd/ports.conf.bak /etc/httpd/ports.conf
sudo sed -i.bak -e "/Listen 80/a Listen 81" /etc/httpd/ports.conf

sudo service httpd restart
