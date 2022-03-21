#!/bin/bash

apt -qy install npm
npm install
npm run prod

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install

rm -rf ./aws
rm -f awscliv2.zip
