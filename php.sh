#!/bin/bash

# Exit on any error
set -e

echo "🚀 Starting System Update..."
sudo apt update -y && sudo apt upgrade -y

echo "📦 Installing Essential Utilities..."
sudo apt install -y git tree unzip curl software-properties-common

---
### 1. Web Server & Database
---

echo "🌐 Installing Nginx..."
sudo apt install -y nginx

echo "💾 Installing MySQL Server..."
sudo apt install -y mysql-server

---
### 2. PHP 8.2 & Extensions
---

echo "🐘 Installing PHP 8.2 and FPM..."
sudo apt install -y php8.2 php8.2-fpm php8.2-mysql php8.2-xml \
php8.2-mbstring php8.2-curl php8.2-gd php8.2-bcmath php8.2-zip php8.2-cli

---
### 3. Language Runtimes (Node.js & Composer)
---

echo "🟢 Installing Node.js 18..."
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt install -y nodejs

echo "🎼 Installing Composer..."
if [ ! -f /usr/local/bin/composer ]; then
    curl -sS https://getcomposer.org/installer | php
    sudo mv composer.phar /usr/local/bin/composer
fi

---
### 4. Application Build & SSL
---

echo "🏗️  Building Application Dependencies..."
# Ensure you are in the project directory before running these
if [ -f "composer.json" ]; then
    composer install --no-dev --optimize-autoloader
fi

if [ -f "package.json" ]; then
    npm install
    npm run build
fi

echo "🔒 Installing SSL (Certbot)..."
sudo apt install -y certbot python3-certbot-nginx

echo "✅ Setup Complete!"
