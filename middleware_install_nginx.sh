#!/usr/bin/env bash
# install_nginx.sh - install Nginx, deploy the reverse-proxy config, validate and reload.
set -euo pipefail
[ "$(id -u)" -eq 0 ] || { echo "Run as root (sudo)"; exit 2; }
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
apt-get update -y && apt-get install -y nginx
install -m 644 "$SCRIPT_DIR/nginx-reverse-proxy.conf" /etc/nginx/conf.d/app.conf
rm -f /etc/nginx/sites-enabled/default
nginx -t                      # fail here if config is invalid
systemctl enable --now nginx
systemctl reload nginx
echo "Nginx reverse proxy active"
