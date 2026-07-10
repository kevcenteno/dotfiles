#!/bin/sh

set -eu

SCRIPT_DIR=$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)
# shellcheck source=lib.sh
. "$SCRIPT_DIR/lib.sh"

require_command sudo
require_command apt-get

if ! command -v add-apt-repository >/dev/null 2>&1; then
  info "installing the APT repository helper"
  sudo apt-get update
  sudo apt-get install -y software-properties-common
fi

if ! grep -Rqs 'ppa.launchpadcontent.net/git-core/ppa' /etc/apt/sources.list /etc/apt/sources.list.d 2>/dev/null; then
  info "enabling the Git Core PPA for the current stable Git release"
  sudo add-apt-repository -y ppa:git-core/ppa
fi

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
