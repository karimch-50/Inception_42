#!/bin/bash

Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
NC='\033[0m' # No Color

mkdir -p wordpress

cd wordpress

sed -i "s|listen = /run/php/php7.4-fpm.sock|listen = 0.0.0.0:9000|" /etc/php/7.4/fpm/pool.d/www.conf

if [ -f "/var/www/html/wordpress/wp-config.php" ]; then
    echo -e "${Yellow} Wordpress already has been setupped !!${NC}"
else
    echo -e "${Yellow}Downloading wp-cli ...${NC}"
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    echo -e "${Green}wp-cli is downloaded !!${NC}"

    chmod +x wp-cli.phar

    mv wp-cli.phar /usr/local/bin/wp

    # Download wordpress with a specific language
    echo -e "${Yellow}Downloading WordPress ...${NC}"
    wp core download --locale=en_US --allow-root
    echo -e "${Green}WordPress downloaded !!${NC}"

    wp config create --dbname=$DATABASE_NAME \
                    --dbuser=$DB_USER_NAME \
                    --dbhost=mariadb \
                    --dbpass=$DB_USER_PASS \
                    --dbprefix="wp_" \
                    --allow-root \
                    --skip-check #the database connection is not checked

    # Install WordPress
    wp core install --allow-root \
                    --title="$WP_TITLE" \
                    --admin_user=$WP_ADMIN \
                    --admin_password=$WP_ADMIN_PASS \
                    --admin_email=$WP_ADMIN_EMAIL \
                    --url=$DOMAIN_NAME

    # echo "Creating users..."
    wp user create $WP_USER_NAME $WP_USER_EMAIL \
        --role=$WP_ROLE \
        --user_pass=$WP_USER_PASS \
        --allow-root
    echo -e "${Green}=====> Wordpress have been installed and set up successfully${NC}"
fi

exec "$@"