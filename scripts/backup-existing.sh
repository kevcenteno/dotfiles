#!/bin/sh

set -eu

SCRIPT_DIR=$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)
# shellcheck source=lib.sh
. "$SCRIPT_DIR/lib.sh"

backup_root="$DOTFILES_STATE_DIR/backups/$(date +%Y%m%d-%H%M%S)"
targets='.zshrc .gitconfig .gitignore .tmux.conf .config/nvim .config/ghostty .config/workmux .vimrc .vim .wezterm.lua .z.sh'

umask 077
mkdir -p "$backup_root"

for target in $targets; do
  source="$HOME/$target"
  [ -e "$source" ] || [ -L "$source" ] || continue
  destination="$backup_root/$target"
  mkdir -p "$(dirname "$destination")"
  if [ -L "$source" ]; then
    # Preserve the linked file or directory itself. Moving the link would make
    # the backup depend on the old checkout continuing to exist.
    cp -RL "$source" "$destination"
    rm "$source"
  else
    mv "$source" "$destination"
  fi
done

chmod 700 "$DOTFILES_STATE_DIR" "$DOTFILES_STATE_DIR/backups" "$backup_root" 2>/dev/null || true
info "backed up existing dotfiles to $backup_root"
