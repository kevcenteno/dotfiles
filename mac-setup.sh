#!/bin/bash

# Symlink
sh ./symlink.sh

# Common Formulae
echo "Installing common formulae"
brew install chruby ruby-install zsh node vim tmux wget the_silver_searcher
sudo mv /usr/bin/vim /usr/bin/vim72

# change default shell to zsh
echo "Change default shell to zsh"
chsh -s /usr/local/bin/zsh $USER

# ruby versions
echo "Ruby install 2.1.2"
ruby-install ruby 2.1.2

# node packages
echo "Installing yeoman and angular generator"
npm install -g yo
npm install -g generator-angular
npm install -g trash

# oh my zsh
echo "Installing oh my zsh"
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

echo "#######"
echo "#######"
echo " DONE! "
echo "#######"
echo "#######"
