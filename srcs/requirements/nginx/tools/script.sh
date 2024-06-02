#!/bin/bash

Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
NC='\033[0m' # No Color

# -x509 : used to output a self signed certificate instead of a certificate request

# -nodes : indicates that the certificate should not be encrypted
#          stands for {no DES (Data Encryption Standard)}

# -out: specifies the output file of the generated self signed certificate

# -keyout: specifies the output file of the generated private key


if [ ! -f "/etc/ssl/certificate.crt" ]; then
    echo -e "${Yellow}Start creating Certificate ...${NC}"

    openssl req -newkey rsa:2048 \
            -x509 \
            -sha256 \
            -days 365 \
            -nodes \
            -out /etc/ssl/certificate.crt \
            -keyout /etc/ssl/private.key \
            -subj "/C=MA/ST=Med/L=Med/O=1337 School/OU=med/CN=med/"

    echo -e "${Green}=====> Certificate is created successfully${NC}"
fi

exec "$@"