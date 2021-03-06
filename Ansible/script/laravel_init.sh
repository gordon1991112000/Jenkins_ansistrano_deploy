#!/bin/bash

domain=$@

PATH="/root/.nvm/versions/node/v12.18.4/bin:$PATH"

cd /home/web
sed -i 's/git\@git2.broadlearning.com:ryan/ssh\:\/\/git\@10.0.80.87:2022\/bobpang/g' composer.json
sed -i 's/git2.broadlearning.com:22022\/ryan/10.0.80.87:2022\/bobpang/g' composer.lock
sed -i '5 s/--hide-modules //' package.json
composer install
npm install
npm ci
#npm ci && npm run dev
php artisan vendor:publish --provider="Gecche\Multidomain\Foundation\Providers\DomainConsoleServiceProvider"
php artisan domain:add $domain
yes | php artisan migrate:fresh --domain=$domain
yes | php artisan db:seed --domain=$domain
yes | php artisan migrate --domain=$domain
npx mix
php artisan horizon --domain=$domain &
#php artisan tunnel:sync-ip30-school-management --domain=$domain
yes | php artisan migrate --domain=$domain
