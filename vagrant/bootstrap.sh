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
ln -s $HOME/ODL $HOME/Desktop/ODL
# source parameters file
echo "source $HOME/ODL/parameters" >> ~/.bashrc
echo "ready!"
echo "please change parameters to reflect your setting ups"
