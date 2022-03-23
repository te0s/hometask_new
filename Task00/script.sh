#!/bin/bash

yes | apt-get install apache2
yes | apt-get install php-cgi
yes | apt-get install php-cli
yes | apt-get install php-fpm
yes | a2enmod rewrite
yes | service apache2 restart

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