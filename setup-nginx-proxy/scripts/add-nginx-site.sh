#!/bin/bash
set -e

SITE_NAME="$1"
DOMAIN="$2"
PROXY_PORT="$3"
TLS_CERTIFICATE_PATH="$4"
TLS_PRIVATE_KEY_PATH="$5"

NGINX_CONF="/etc/nginx/sites-available/$SITE_NAME"

sudo tee "$NGINX_CONF" > /dev/null <<EOF
# Redirect HTTP to HTTPS
server {
    listen 80;
    listen [::]:80;
    server_name ${DOMAIN};
    return 301 https://\$host\$request_uri;
}

# HTTPS server
server {
    listen 443 ssl;
    listen [::]:443 ssl;
    server_name ${DOMAIN};

    ssl_certificate ${TLS_CERTIFICATE_PATH};
    ssl_certificate_key ${TLS_PRIVATE_KEY_PATH};

    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_ciphers HIGH:!aNULL:!MD5;

    location / {
        proxy_pass http://127.0.0.1:$PROXY_PORT;
        proxy_http_version 1.1;

        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }
}
EOF

# Enable site
sudo ln -sf "$NGINX_CONF" "/etc/nginx/sites-enabled/$SITE_NAME"

# Test and reload NGINX
sudo nginx -t && sudo systemctl reload nginx
