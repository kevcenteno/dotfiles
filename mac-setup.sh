#!/bin/bash

# Symlink
sh ./symlink.sh

# Common Formulae
echo "Installing common formulae"
brew install tmux wget

# oh my zsh
echo "Installing oh my zsh"
git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh

echo "Installing bullet train"
wget http://raw.github.com/caiogondim/bullet-train-oh-my-zsh-theme/master/bullet-train.zsh-theme -O ~/.oh-my-zsh/themes/bullet-train.zsh-theme

echo "#######"
echo "#######"
echo " DONE! "
echo "#######"
echo "#######"
