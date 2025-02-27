FROM haproxy:alpine
USER root
RUN apk add --no-cache certbot certbot-dns openssl bash jq curl
COPY ./certbot_entrypoint.sh /certbot_entrypoint.sh
RUN chmod +x /certbot_entrypoint.sh
RUN wget -O dataplaneapi.apk https://github.com/haproxytech/dataplaneapi/releases/download/v3.1.1/dataplaneapi_3.1.1_linux_amd64.apk 
RUN apk add --allow-untrusted dataplaneapi.apk
RUN mkdir /run/haproxy
RUN touch /run/haproxy/admin.sock
COPY ./dataplaneapi.yml /etc/haproxy/dataplaneapi.yaml

VOLUME /etc/letsencrypt
EXPOSE 80 443
ENTRYPOINT ["/certbot_entrypoint.sh"]