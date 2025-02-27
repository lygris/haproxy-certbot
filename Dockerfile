FROM haproxy:alpine
USER root
RUN apk add --no-cache certbot certbot-dns openssl bash
COPY ./certbot_entrypoint.sh /certbot_entrypoint.sh
RUN chmod +x /certbot_entrypoint.sh
RUN wget -O dataplaneapi.apk --allow-untrusted https://github.com/haproxytech/dataplaneapi/releases/download/v3.1.1/dataplaneapi_3.1.1_linux_amd64.apk 
RUN apk add dataplaneapi.apk

VOLUME /etc/letsencrypt
EXPOSE 80 443
ENTRYPOINT ["/certbot_entrypoint.sh"]