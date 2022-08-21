#!/bin/bash
#Install / configure mysql as beackend db for the tasks application.
#Original scripts from Nutanix CALM early version used, modified for ansible deployment.
#Target is an aws ec2 instance
#$1 is the mysql database password, of the homestead database
#hardev@nutanix.com Auh'22

#set -ex

sudo yum install -y "http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm"
sudo yum update -y
sudo setenforce 0 || true
sudo sed -i 's/enforcing/disabled/g' /etc/selinux/config /etc/selinux/config
sudo systemctl stop firewalld || true
sudo systemctl disable firewalld || true
sudo yum install -y mysql-community-server.x86_64
sudo /bin/systemctl start mysqld
sudo /bin/systemctl enable mysqld

#Mysql secure installation
mysql -u root<<-EOF
UPDATE mysql.user SET Password=PASSWORD('$1') WHERE User='root';
FLUSH PRIVILEGES;
EOF
mysql -u root -p$1 <<-EOF
CREATE DATABASE homestead;
GRANT ALL PRIVILEGES ON homestead.* TO 'homestead'@'%' identified by '$1';
GRANT ALL PRIVILEGES ON homestead.* TO 'homestead'@'localhost' identified by '$1';
GRANT ALL PRIVILEGES ON homestead.* TO 'homestead'@'127.0.0.1' identified by '$1';
FLUSH PRIVILEGES;
EOF