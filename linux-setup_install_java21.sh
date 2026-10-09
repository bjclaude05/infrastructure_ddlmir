#!/usr/bin/env bash
# install_java21.sh - idempotent OpenJDK 21 install for Ubuntu/Debian with verification.
set -euo pipefail
[ "$(id -u)" -eq 0 ] || { echo "Run as root (sudo)"; exit 2; }

if java -version 2>&1 | grep -q 'version "21'; then
  echo "Java 21 already installed"; java -version; exit 0
fi
apt-get update -y
apt-get install -y openjdk-21-jdk-headless
JAVA_HOME_PATH="$(dirname "$(dirname "$(readlink -f "$(command -v java)")")")"
echo "JAVA_HOME=${JAVA_HOME_PATH}" > /etc/profile.d/java.sh
java -version
echo "Java 21 installed. JAVA_HOME=${JAVA_HOME_PATH}"
