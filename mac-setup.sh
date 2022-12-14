#!/bin/bash

# Symlink
sh ./symlink.sh

# Common Formulae
echo "Installing common formulae"
brew install tmux wget

# oh my zsh
echo "Installing oh my zsh"
git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh

echo "#######"
echo "#######"
echo " DONE! "
echo "#######"
echo "#######"
