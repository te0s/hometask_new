#!/bin/bash
docker run -v /vagrant/index.html:/var/www/html/index.html -d --rm -p 8081:80 hometask-image