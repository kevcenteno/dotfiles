#!/bin/bash

# Install the things
sudo apt-get update && sudo apt-get install -y \
  build-essential \
  cmake \
  curl \
  fzf \
  g++ \
  gcc \
  libbz2-dev \
  libffi-dev \
  liblzma-dev \
  libncursesw5-dev \
  libreadline-dev \
  libsqlite3-dev \
  libssl-dev \
  libxml2-dev \
  libxmlsec1-dev \
  jq \
  make \
  ncurses-term \
  pkg-config \
  python3 \
  python3-pip \
  python3-venv \
  ripgrep \
  software-properties-common \
  tmux \
  zsh

# Install neovim from latest GitHub release to /opt, matching the path zshrc expects
NVIM_VERSION=$(curl -s https://api.github.com/repos/neovim/neovim/releases/latest | jq -r '.tag_name')
ARCH=$(uname -m)
if [ "$ARCH" = "aarch64" ]; then
  NVIM_ARCH="nvim-linux-arm64"
else
  NVIM_ARCH="nvim-linux-x86_64"
fi
curl -L "https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/${NVIM_ARCH}.tar.gz" -o "/tmp/${NVIM_ARCH}.tar.gz"
sudo rm -rf "/opt/${NVIM_ARCH}"
sudo tar -C /opt -xzf "/tmp/${NVIM_ARCH}.tar.gz"

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

# pyenv
curl https://pyenv.run | bash
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
pyenv install --skip-existing 3.12
pyenv global 3.12

# uv
curl -LsSf https://astral.sh/uv/install.sh | sh
export PATH="$HOME/.local/bin:$PATH"

# graphify
uv tool install --reinstall graphifyy

# nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.5/install.sh | bash

# workmux
curl -fsSL https://raw.githubusercontent.com/raine/workmux/main/scripts/install.sh | bash

echo ">>>"
echo ">>> Installed the things"
echo ">>>"

# github cli
(type -p wget >/dev/null || (sudo apt update && sudo apt install wget -y)) \
	&& sudo mkdir -p -m 755 /etc/apt/keyrings \
	&& out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg \
	&& cat $out | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
	&& sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
	&& sudo mkdir -p -m 755 /etc/apt/sources.list.d \
	&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
	&& sudo apt update \
	&& sudo apt install gh -y

# install ghostty
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/mkasberg/ghostty-ubuntu/HEAD/install.sh)"

exec zsh
