FROM nginx:1.21

RUN apt-get update && apt-get -y install openssl \
    && openssl req -newkey rsa:2048 -x509 -nodes -set_serial 1 -days 3650 \
       -subj "/C=JP/ST=Tokyo/L=Chiyoda-ku" \
       -keyout "/etc/ssl/private/server.key" -out "/etc/ssl/private/server.crt" \
    && chmod 400 /etc/ssl/private/server.*
