#!/bin/bash

HASH=`git rev-parse --short HEAD`
BUNDLE="bundle-$HASH.tar.gz"
S3_ENPOINT="s3://$S3_BUCKET/bundles"

rm -rf bundle-*.tar.gz

tar \
    --exclude="*.git" \
    --exclude="storage/logs/*" \
    --exclude="vendor/*" \
    --exclude="bootstrap/cache/*" \
    --exclude=".env" \
    --exclude="node_modules/*" \
    -zcf $BUNDLE -T bundle.conf > /dev/null 2>&1

# Install aws cli (used by deploy scripts)
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install
rm -rf ./aws
rm -f awscliv2.zip

aws s3 cp $BUNDLE $S3_ENPOINT > /dev/null 2>&1
echo "[-] Your CodeDeploy S3 enpoint will be: $S3_ENPOINT";

aws deploy create-deployment \
    --application-name $APPLICATION_NAME \
    --deployment-config-name $DEPLOYMENT_CONFIG_NAME \
    --deployment-group-name $DEPLOYMENT_GROUP_NAME \
    --file-exists-behavior OVERWRITE \
    --s3-location $bucket=$S3_BUCKET,bundleType=tgz,key=bundles/$BUNDLE
