#!/bin/bash

sh ./symlink.sh

# Install the things
sudo apt-get update
sudo apt-get -y dist-upgrade
sudo add-apt-repository -y ppa:chris-lea/node.js
sudo apt-get update
sudo apt-get install -y python-software-properties python g++ make libssl-dev pkg-config build-essential curl gcc vim xsel tmux zsh ncurses-term nodejs silversearcher-ag

# Colors
echo "export TERM=xterm-256color" >> $HOME/.bashrc
source $HOME/.bashrc
echo "source $HOME/.bashrc" >> $HOME/.bash_profile

# oh my zsh
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

# Grunt
sudo npm install -g grunt-cli

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

# Prompt to install Ruby

function install_ruby {
  ruby-install ruby $1;
  echo "chruby ruby-$1" >> $HOME/.zshrc;
}

function what_version {
  while true; do
    read -p "Which version?  Please enter a specific version number.  Type 'q' to exit: " version
    case $version in
      [q]* ) exit;;
      * ) install_ruby $version; break;;
    esac
  done
}

while true; do
  read -p "Do you want to install Ruby? [y/n]: " yn
  case $yn in
    [Yy]* ) what_version; break;;
    [Nn]* ) exit;;
    * ) echo "Please answer y or n.";;
  esac
done

echo ">>>"
echo ">>> Installed the things"
echo ">>>"


