#!/bin/bash
composer install --no-interaction
npm install

ln -f -s .env.pipelines .env

php artisan migrate --no-interaction
php artisan key:generate

npm run prod
