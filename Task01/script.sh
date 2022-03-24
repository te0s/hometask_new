#!/bin/bash


sudo yum update -y
sudo yum install -y httpd
sudo yum install -y mysql-server
sudo yum install -y php
sudo yum install -y mc


sudo systemctl enable httpd
sudo systemctl start httpd
sudo systemctl start mysqld