#!/bin/bash

# Install the things
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt-get update && sudo apt-get install -y \
  build-essential \
  cmake \
  curl \
  fzf \
  g++ \
  gcc \
  libssl-dev \
  jq \
  make \
  ncurses-term \
  neovim \
  pkg-config \
  python3 \
  python3-pip \
  python3-venv \
  ripgrep \
  software-properties-common \
  tmux \
  vim \
  zsh

# zsh is the default shell
sudo chsh -s $(which zsh) $(whoami)

# oh my zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Create the custom themes directory if it doesn't exist
mkdir -p ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes

# Download the bullet-train theme
curl -L http://raw.github.com/caiogondim/bullet-train-oh-my-zsh-theme/master/bullet-train.zsh-theme -o ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/bullet-train.zsh-theme

# Symlink config files
sh ./symlink.sh

# Use mise to install runtimes
curl https://mise.run | sh
eval "$(~/.local/bin/mise activate bash)"
mise use -g go@latest
mise use -g node@lts

echo ">>>"
echo ">>> Installed the things"
echo ">>>"

exec zsh
