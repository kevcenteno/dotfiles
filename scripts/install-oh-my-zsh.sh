#!/bin/sh

set -eu

ZSH_DIR=${ZSH:-"$HOME/.oh-my-zsh"}
THEME_DIR="$ZSH_DIR/custom/themes"
XDG_DATA_HOME=${XDG_DATA_HOME:-"$HOME/.local/share"}
VENDOR_DIR="$XDG_DATA_HOME/dotfiles/vendor"
OH_MY_ZSH_REVISION=677a4592b18c08ddea737f8aca70bac0e9fc9313
BULLET_TRAIN_REVISION=d60f62c34b3d9253292eb8be81fb46fa65d8f048

if [ ! -d "$ZSH_DIR/.git" ]; then
  git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git "$ZSH_DIR"
fi
git -C "$ZSH_DIR" fetch --depth=1 origin "$OH_MY_ZSH_REVISION"
git -C "$ZSH_DIR" checkout --detach "$OH_MY_ZSH_REVISION"

theme_source="$VENDOR_DIR/bullet-train"
if [ ! -d "$theme_source/.git" ]; then
  mkdir -p "$VENDOR_DIR"
  git clone --depth=1 https://github.com/caiogondim/bullet-train-oh-my-zsh-theme.git "$theme_source"
fi
git -C "$theme_source" fetch --depth=1 origin "$BULLET_TRAIN_REVISION"
git -C "$theme_source" checkout --detach "$BULLET_TRAIN_REVISION"
mkdir -p "$THEME_DIR"
install -m 644 "$theme_source/bullet-train.zsh-theme" "$THEME_DIR/bullet-train.zsh-theme"
