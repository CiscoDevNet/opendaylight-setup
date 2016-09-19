#!/usr/bin/env bash

REPO_URL='https://github.com/kevinxw/opendaylight-setup.git'

sudo apt-get install -y git
git clone -q ${REPO_URL} ODL
cd ODL
./bin/setup-env
./bin/setup-odl beryllium
cd ..
chown -R vagrant:vagrant *
# now create a shortcut to Desktop
ln -s $HOME/ODL $HOME/Desktop/ODL
# source parameters file
sudo apt-get -y clean
echo "source $HOME/ODL/parameters" >> ~/.bashrc
echo "ready!"
echo "please change parameters to reflect your setting ups"
