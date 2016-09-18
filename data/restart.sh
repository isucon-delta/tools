#!/bin/bash

cd /home/isucon/webapp
git pull origin master

if [ -f /var/lib/mysql/mysqld-slow.log ]; then
    sudo mv /var/lib/mysql/mysqld-slow.log /var/lib/mysql/mysqld-slow.log.$(date "+%Y%m%d_%H%M%S")
fi
if [ -f /var/log/nginx/access.log ]; then
    sudo mv /var/log/nginx/access.log /var/log/nginx/access.log.$(date "+%Y%m%d_%H%M%S")
fi

sudo cp nginx.conf /etc/nginx/nginx.conf
sudo cp my.cnf /etc/mysql.cnf

sudo systemctl restart isutar.php.service
sudo systemctl restart isuda.php.service
sudo systemctl restart mysql.service
sudo systemctl restart nginx.service
