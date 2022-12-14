#!/bin/bash

# Project directory on the server fro your project
export WEB_DIR='/var/www/laravelcodedeploy'
# Your server user. Used to fix permission issue & install our project dependcies
export WEB_USER=ubuntu

# Change directory to project.
cd $WEB_DIR

# change user owner to ubuntu & fix storage permission issues.
sudo chown -R ubuntu:ubuntu .
sudo chown -R www-data storage
sudo chmod -R u+x .
sudo chmod g+w -R storage

# install composer dependcies
sudo -u $WEB_USER composer install --no-dev --no-progress --prefer-dist

./devops/scripts/generate-env.sh

# generate app key & run migrations
sudo -u $WEB_USER php artisan key:generate
sudo -u $WEB_USER php artisan migrate --force --no-interaction
