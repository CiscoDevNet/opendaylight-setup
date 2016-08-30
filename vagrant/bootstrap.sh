#!/usr/bin/env bash

REPO_URL='https://github.com/kevinxw/opendaylight-setup.git'

sudo apt-get update
sudo apt-get install -y git
git clone -q ${REPO_URL} ODL
cd ODL
./bin/setup-env
./bin/download_distro release
./bin/unpack-odl 
cd ..
chown -R vagrant:vagrant *
echo "ready!"
echo "please change parameters to reflect your setting ups"
