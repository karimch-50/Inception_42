FROM debian:bullseye

WORKDIR /

RUN apt-get update -y && apt-get install -y mariadb-server

COPY tools/script.sh /usr/local/bin/db_script

RUN chmod +x /usr/local/bin/db_script

ENTRYPOINT ["db_script"]

CMD ["mariadbd"]