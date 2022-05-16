FROM alpine:latest
RUN  apt-get -y update && apt-get install -y apache2 php libapache2-mod-php php-cgi php-cli && rm /var/www/html/index.html
ADD  https://raw.githubusercontent.com/te0s/hometask_new/main/Task00/sites/01-demosite-php/index.php /var/www/html/index.php
RUN  chmod -R 755 /var/www/html/index.php
ENTRYPOINT ["apache2ctl", "-D", "FOREGROUND"]