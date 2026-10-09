#!/usr/bin/env bash
# docker_install.sh - install Docker Engine from the official apt repository (no curl | sh).
set -euo pipefail
[ "$(id -u)" -eq 0 ] || { echo "Run as root (sudo)"; exit 2; }
command -v docker &>/dev/null && { echo "Docker already installed"; docker --version; exit 0; }
apt-get update -y
apt-get install -y ca-certificates curl gnupg
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" > /etc/apt/sources.list.d/docker.list
apt-get update -y
apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
systemctl enable --now docker
docker --version
