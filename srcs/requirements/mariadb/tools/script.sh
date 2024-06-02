#!/bin/bash

Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
NC='\033[0m' # No Color

# Set permissions on directories
mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld
mkdir -p /var/lib/mysql && chown -R mysql:mysql /var/lib/mysql

sed -i "s/127.0.0.1/0.0.0.0/" /etc/mysql/mariadb.conf.d/50-server.cnf

service mariadb start
mariadb <<-EOF
CREATE DATABASE $DATABASE_NAME;
CREATE USER '$DB_USER_NAME' IDENTIFIED BY '$DB_USER_PASS';
GRANT ALL PRIVILEGES ON $DATABASE_NAME.* TO '$DB_USER_NAME'@'%';
FLUSH PRIVILEGES;
EOF

service mariadb stop

echo -e "${Green}=====> Mariadb have been installed and set up successfully${NC}"

exec "$@"