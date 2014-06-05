#!/bin/bash

# Copy them dotfiles
cp -r prefs/. $HOME/

echo ">>>"
echo ">>> Copied dotfiles"
echo ">>>"

# Install the things
sudo apt-get update
sudo apt-get -y dist-upgrade
sudo apt-get install -y python-software-properties python g++ make libssl-dev pkg-config git-core build-essential curl gcc vim xsel kupfer tmux zsh ncurses-term terminator chromium-browser

# Colors
echo "export TERM=xterm-256color" >> $HOME/.bashrc
source $HOME/.bashrc
echo "source $HOME/.bashrc" >> $HOME/.bash_profile

# Node
sudo add-apt-repository ppa:chris-lea/node.js
sudo apt-get update
sudo apt-get -y install nodejs

# Grunt
sudo npm install -g grunt-cli

# oh my zsh
wget --no-check-certificate http://install.ohmyz.sh -O - | sh

# chruby
wget -O chruby-0.3.8.tar.gz https://github.com/postmodern/chruby/archive/v0.3.8.tar.gz
tar -xzvf chruby-0.3.8.tar.gz
cd chruby-0.3.8/
sudo make install
cd ../ && rm -rf chruby-0.3.8 chruby-0.3.8.tar.gz

# Ruby Build
wget -O ruby-install-0.4.3.tar.gz https://github.com/postmodern/ruby-install/archive/v0.4.3.tar.gz
tar -xzvf ruby-install-0.4.3.tar.gz
cd ruby-install-0.4.3/
sudo make install
cd ../ && rm -rf ruby-install-0.4.3 ruby-install-0.4.3.tar.gz

echo "source /usr/local/share/chruby/chruby.sh" >> $HOME/.zshrc
echo "source /usr/local/share/chruby/auto.sh" >> $HOME/.zshrc

ruby-install ruby 2.0.0-p353
echo "chruby ruby-2.0.0-p353" >> $HOME/.zshrc

echo ">>>"
echo ">>> Installed the things"
echo ">>>"


