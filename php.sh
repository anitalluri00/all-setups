#!/bin/bash

# 1. Stop on error and print commands
set -e

echo "------------------------------------------"
echo "🚀 Starting System Update..."
echo "------------------------------------------"
sudo apt update -y && sudo apt upgrade -y

# 2. Essential Utilities
echo "📦 Installing Essential Utilities..."
sudo apt install -y git tree unzip curl software-properties-common

# 3. Web Server & Database
echo "🌐 Installing Nginx..."
sudo apt install -y nginx

echo "💾 Installing MySQL Server..."
sudo apt install -y mysql-server

# 4. PHP 8.2 & Extensions
echo "🐘 Installing PHP 8.2 and FPM..."
sudo apt install -y php8.2 php8.2-fpm php8.2-mysql php8.2-xml \
php8.2-mbstring php8.2-curl php8.2-gd php8.2-bcmath php8.2-zip php8.2-cli

# 5. Language Runtimes (Node.js 18 & Composer)
echo "🟢 Installing Node.js 18..."
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt install -y nodejs

echo "🎼 Installing Composer..."
if ! command -v composer &> /dev/null; then
    curl -sS https://getcomposer.org/installer | php
    sudo mv composer.phar /usr/local/bin/composer
else
    echo "Composer is already installed."
fi

# 6. Application Build & SSL
echo "🏗️  Building Application..."
# Check if in a project directory
if [ -f "composer.json" ]; then
    composer install --no-dev --optimize-autoloader
fi

if [ -f "package.json" ]; then
    npm install
    npm run build
fi

echo "🔒 Installing SSL (Certbot)..."
sudo apt install -y certbot python3-certbot-nginx

echo "------------------------------------------"
echo "✅ Setup Complete!"
echo "------------------------------------------"
