FROM debian:bullseye

WORKDIR /var/www/html

RUN mkdir -p /run/php

RUN apt-get update -y && apt-get install -y php-fpm php-mysql mariadb-client curl

COPY tools/script.sh /usr/local/bin/wp_script

RUN chmod +x /usr/local/bin/wp_script

ENTRYPOINT ["wp_script"]

# -F stay in the forgound
CMD ["php-fpm7.4", "-F"]