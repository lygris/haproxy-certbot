FROM haproxy:alpine
USER root
RUN apk add --no-cache certbot-dns openssl bash
COPY ./certbot_entrypoint.sh /certbot_entrypoint.sh
RUN chmod +x /certbot_entrypoint.sh

VOLUME /etc/letsencrypt
EXPOSE 80 443
ENTRYPOINT ["/certbot_entrypoint.sh"]