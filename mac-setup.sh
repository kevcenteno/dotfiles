#!/bin/bash

# Symlink
sh ./symlink.sh

# Homebrew
echo "Installing homebrew and common formulae"
ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go/install)"
brew doctor
brew install git chruby ruby-install zsh node vim tmux

# change default shell to zsh
echo "Change default shell to zsh"
chsh -s /usr/local/bin/zsh $USER

# ruby versions
echo "Ruby install 2.0.0"
ruby-install ruby 2.0.0

# node packages
echo "Installing yeoman and angular generator"
npm install -g yo
npm install -g generator-angular

# oh my zsh
echo "Installing oh my zsh"
wget --no-check-certificate http://install.ohmyz.sh -O - | sh

# setting up chruby
echo -n "Setting up chruby ..."
echo "source /usr/local/share/chruby/chruby.sh" >> $HOME/.zshrc
echo "source /usr/local/share/chruby/auto.sh" >> $HOME/.zshrc
echo "chruby ruby-2.0.0" >> $HOME/.zshrc
echo "done"

echo "#######"
echo "#######"
echo " DONE! "
echo "#######"
echo "#######"
