#!/bin/bash

# aws paramater store name & region
PARAMATER="laraveldevops_env"
REGION="ap-southeast-1"

# Get parameters and put it into .env file inside application root
aws ssm get-parameter \
  --with-decryption \
  --name $PARAMATER \
  --region $REGION \
  --with-decryption \
  --query Parameter.Value \
  --output text > $WEB_DIR/.env

# Chưa load được nội dung của env nên cần phân quyền

# Clear laravel configuration cache
chown $WEB_USER. .env
sudo -u $WEB_USER php artisan config:clear
