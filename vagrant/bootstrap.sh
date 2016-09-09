#!/usr/bin/env bash

REPO_URL='https://github.com/kevinxw/opendaylight-setup.git'

sudo apt-get install -y git
git clone -q ${REPO_URL} ODL
cd ODL
./bin/setup-odl
cd ..
sudo apt-get install -y vim
chown -R vagrant:vagrant *
# now create a shortcut to Desktop
ln -s $(pwd)/ODL $(pwd)/Desktop/ODL
echo "ready!"
echo "please change parameters to reflect your setting ups"
