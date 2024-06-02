FROM debian:bullseye

WORKDIR /

RUN apt-get update -y && apt-get install -y nginx openssl

COPY config/config.conf /etc/nginx/sites-available/default

COPY tools/script.sh /usr/local/bin/server_script

RUN chmod +x /usr/local/bin/server_script

ENTRYPOINT ["server_script"]

# run nginx in the forgound
CMD ["nginx", "-g", "daemon off;"]