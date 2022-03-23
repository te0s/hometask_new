#!/bin/bash

dnf install -y httpd
dnf install -y mysql-server
dnf install -y php


systemctl enable httpd
systemctl start httpd
systemctl start mysqld