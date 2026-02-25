sudo apt update -y && sudo apt upgrade -y
# Install Git & tree
sudo apt install git tree -y
# Install Nginx
sudo apt install nginx -y
# Install PHP 8.2 + Extensions
sudo apt install php8.2 php8.2-fpm php8.2-mysql php8.2-xml php8.2-mbstring php8.2-curl php8.2-gd php8.2-bcmath php8.2-zip php8.2-cli unzip git curl -y
# Install MySQL 8
sudo apt install mysql-server -y
# Install NodeJS 18
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt install nodejs -y
# Install Composer
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
composer install
npm install
npm run build
