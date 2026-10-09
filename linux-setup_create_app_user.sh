#!/usr/bin/env bash
# create_app_user.sh - dedicated non-login service account and directories (least privilege).
set -euo pipefail
APP="${1:-myapp}"
id "$APP" &>/dev/null || useradd --system --home "/opt/$APP" --shell /usr/sbin/nologin "$APP"
install -d -o "$APP" -g "$APP" -m 750 "/opt/$APP" "/var/log/$APP"
echo "Service account '$APP' ready"
