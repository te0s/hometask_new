#!/bin/bash

sudo -y apt-get install apache2
sudo -y apt-get install php-cgi
sudo -y apt-get install php-cli
sudo -y apt-get install php-fpm
sudo -y apt-get install libapache2-mod-php
sudo -y apt-get install libapache2-mpm-itk
a2enmod rewrite
service apache2 restart

rm /etc/apache2/sites-available/01-demosite-static.conf
touch /etc/apache2/sites-available/01-demosite-static.conf
cat <<PAST | tee -a /etc/apache2/sites-available/01-demosite-static.conf
<VirtualHost *:80>
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/html/01-demosite-static
        DirectoryIndex index.html
        ErrorLog \${APACHE_LOG_DIR}/error.log
        CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
PAST

rm /etc/apache2/sites-available/01-demosite-php.conf
touch /etc/apache2/sites-available/01-demosite-php.conf
cat <<PAST | tee -a /etc/apache2/sites-available/01-demosite-php.conf
<VirtualHost *:81>
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/html/01-demosite-php
        DirectoryIndex index.php
        ErrorLog \${APACHE_LOG_DIR}/error.log
        CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
PAST

sudo a2ensite 01-demosite-static.conf
sudo a2ensite 01-demosite-php.conf
rm /etc/apache2/sites-enabled/000-default.conf

cp /etc/apache2/ports.conf.bak /etc/apache2/ports.conf
sed -i.bak -e "/Listen 80/a Listen 81" /etc/apache2/ports.conf

service apache2 restart