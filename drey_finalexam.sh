#!/bin/sh

#Installing HTTPD service

echo "Installing HTTPD"

yum install -y httpd

echo "Starting HTTPD"

systemctl start httpd.service


#Implementing firewall 


firewall-cmd --permanent --add-port=80/tcp
firewall-cmd --permanent --add-port=443/tcp
firewall-cmd --reload

#Intalling php-mysql
yum install -y php php-mysql

#To restart httpd
systemctl restart httpd.service


yum info php-fpm

#Installing php-fpm
yum install -y php-fpm

cd /var/www/html/
echo '<?php phpinfo(); ?>' > index.php

# To install the mariadb-server mariadb
yum install -y mariadb-server mariadb

# To start the mariadb
systemctl start mariadb


mysql_secure_installation <<EOF

y
jindrey34
jindrey34
y
y
y
y
EOF

# To enable the mariadb
systemctl enable mariadb




mysqladmin -u root -pjindrey34 version

echo "CREATE DATABASE wordpress; CREATE USER pat@localhost IDENTIFIED BY 'jindrey34'; GRANT ALL PRIVILEGES ON wordpress.* TO root@localhost IDENTIFIED BY 'jindrey34'; FLUSH PRIVILEGES; show databases;" | mysql -u root -pjindrey34

# Installing the php-gd
yum install -y php-gd

# To restart httpd
service httpd restart

# Installing wget
yum install -y wget


yum install -y tar

cd /opt/
wget http://wordpress.org/latest.tar.gz
tar xzvf latest.tar.gz

# Installation of rsync
yum install -y rsync
rsync -avP wordpress/ /var/www/html/
cd /var/www/html/
mkdir /var/www/html/wp-content/uploads
chown -R apache:apache /var/www/html/*
cp wp-config-sample.php wp-config.php
sed -i 's/database_name_here/wordpress/g' wp-config.php
sed -i 's/username_here/root/g' wp-config.php
sed -i 's/password_here/jindrey34/g' wp-config.php


yum install -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm
yum install -y yum-utils
yum-config-manager --enable remi-php56
yum install -y php php-mcrypt php-cli php-gd php-curl php-mysql php-ldap php-zip php-fileinfo
systemctl restart httpd.service