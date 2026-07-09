#!/bin/sh

set -eu

SCRIPT_DIR=$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)
# shellcheck source=lib.sh
. "$SCRIPT_DIR/lib.sh"

require_command sudo
require_command apt-get

if ! command -v mise >/dev/null 2>&1; then
  info "installing mise from its signed APT repository"
  sudo apt-get update
  sudo apt-get install -y extrepo
  sudo extrepo enable mise
fi

sudo apt-get update
sudo apt-get install -y mise
if sed '/^[[:space:]]*#/d; /^[[:space:]]*$/d' \
  "$REPO_DIR/manifests/apt/common.txt" "$REPO_DIR/manifests/apt/$DOTFILES_PROFILE.txt" \
  | grep -q .; then
  # Deliberately install only declared packages; upgrades are a separate task.
  sed '/^[[:space:]]*#/d; /^[[:space:]]*$/d' \
    "$REPO_DIR/manifests/apt/common.txt" "$REPO_DIR/manifests/apt/$DOTFILES_PROFILE.txt" \
    | xargs -r sudo apt-get install -y
fi

if is_desktop_profile; then
  "$SCRIPT_DIR/install-ghostty-ubuntu.sh"
fi
