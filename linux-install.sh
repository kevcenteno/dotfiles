#!/bin/bash

apt-get update
apt-get install -y python-software-properties python g++ make libssl-dev git-core pkg-config build-essential curl gcc vim xsel kupfer tmux zsh

add-apt-repository ppa:chris-lea/node.js
apt-get update
apt-get install node

npm install -g grunt-clil
