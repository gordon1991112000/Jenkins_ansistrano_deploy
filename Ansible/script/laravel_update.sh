#!/bin/bash

domain=$@

PATH="/root/.nvm/versions/node/v12.18.4/bin:$PATH"

cd /home/web
#php artisan horizon:terminate --domain=$domain
yes | php artisan migrate --domain=$domain
#composer install
npm ci
#In prod use: npx mix production
npx mix
php artisan cache:clear --domain=$domain
php artisan view:clear --domain=$domain
php artisan config:clear --domain=$domain
php artisan horizon --domain=$domain &
