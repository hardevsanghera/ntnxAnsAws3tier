#!/bin/bash
#Install / configure mysql as beackend db for the tasks application.
#Original scripts from Nutanix CALM early version used, modified for ansible deployment.
#Target is an aws ec2 instance
#$1 is the mysql database password, of the homestead database
#hardev@nutanix.com Aug'22
set -ex

sudo yum install -y "http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm"
sudo yum update -y
sudo setenforce 0 || true
sudo sed -i 's/enforcing/disabled/g' /etc/selinux/config /etc/selinux/config
sudo systemctl stop firewalld || true
sudo systemctl disable firewalld || true
sudo yum install -y mysql-community-server.x86_64 unzip zip lvm2 lsof ntp
sudo ntpdate -u -s 0.pool.ntp.org 1.pool.ntp.org 2.pool.ntp.org 3.pool.ntp.org
sudo systemctl enable ntpd
sudo systemctl restart ntpd
#Setup sshd to allow password logins / root
sudo sed -i 's/\#PermitRootLogin yes/PermitRootLogin yes/g' /etc/ssh/sshd_config
sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sudo systemctl restart sshd
sudo bash -c 'echo "Defaults umask_override" >> /etc/sudoers'
sudo bash -c 'echo "Defaults umask=0002" >> /etc/sudoers'

#Alter mysql to support Nutanix DB Service
sudo bash -c 'echo "[mysqld]" >> /etc/my.cnf'
sudo bash -c 'echo "bind-address = 0.0.0.0" >> /etc/my.cnf'
sudo bash -c 'echo "log-bin=mysql-bin.log" >> /etc/my.cnf'
sudo /bin/systemctl start mysqld
sudo /bin/systemctl enable mysqld

#Mysql create datbase for the app and also access for db root / homestead users
#CREATE USER 'root'@'%' IDENTIFIED BY '$1'; GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
mysql -u root <<-EOF
UPDATE mysql.user SET Password=PASSWORD('$1') WHERE User='homestead';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$1';
CREATE DATABASE homestead;
GRANT ALL PRIVILEGES ON homestead.* TO 'homestead'@'localhost' identified by '$1';
GRANT ALL PRIVILEGES ON homestead.* TO 'homestead'@'127.0.0.1' identified by '$1';
GRANT ALL PRIVILEGES ON homestead.* TO 'homestead'@'%' identified by '$1';
FLUSH PRIVILEGES;
EOF
