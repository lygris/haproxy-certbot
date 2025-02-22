FROM haproxy:alpine
RUN apk add --no-cache certbot openssl bash certbot-nginx
COPY ./certbot_entrypoint.sh ./
RUN chmod +x /certbot_entrypoint.sh

VOLUME /etc/letsencrypt
EXPOSE 80 443
ENTRYPOINT ["/certbot_entrypoint.sh"]