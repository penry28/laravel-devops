#!/bin/bash

php artisan server & sleep 5

./vendor/bin/phpunit
