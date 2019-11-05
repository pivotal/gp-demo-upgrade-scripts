#!/bin/bash

if [ ! -f /usr/local/bin/pivnet ]
then
    wget -O pivnet github.com/pivotal-cf/pivnet-cli/releases/download/v0.0.72/pivnet-linux-amd64-0.0.72 && chmod +x pivnet && sudo mv pivnet /usr/local/bin;
fi

# login with pivnet token
pivnet login --api-token=$PIVNET_TOKEN

pivnet accept-eula -p pivotal-gpdb -r 5.22.0
pivnet accept-eula -p pivotal-gpdb -r 6.0.1
