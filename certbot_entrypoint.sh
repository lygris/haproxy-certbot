#!/bin/bash
set -e

# Check if certificates exist, and obtain if not
if [ ! -f /etc/letsencrypt/live/$domain/combined.pem ]; then
    echo "Obtaining certificates..."
    echo $email $domains
    certbot certonly --agree-tos --no-eff-email --email $email -d $domains --preferred-challenges dns-01 --authenticator dns-cloudflare --dns-cloudflare-credentials cloudflare.ini
    if [ $? -ne 0 ]; then
        echo "Failed to obtain certificates, exiting..."
        exit 1
    fi
    cat /etc/letsencrypt/live/yourdomain.com/fullchain.pem /etc/letsencrypt/live/yourdomain.com/privkey.pem > /etc/letsencrypt/live/yourdomain.com/combined.pem
fi

# Start HAProxy
haproxy -f /usr/local/etc/haproxy/haproxy.cfg