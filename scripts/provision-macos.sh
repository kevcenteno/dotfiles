#!/bin/sh

set -eu

SCRIPT_DIR=$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)
# shellcheck source=lib.sh
. "$SCRIPT_DIR/lib.sh"

if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if ! xcode-select -p >/dev/null 2>&1; then
  info "requesting Xcode Command Line Tools"
  xcode-select --install || true
  die "finish the Xcode Command Line Tools installation, then rerun bootstrap"
fi

if ! command -v brew >/dev/null 2>&1; then
  confirm "Install Homebrew using its official installer?" || die "Homebrew is required"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  if [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
fi

brew bundle --file "$REPO_DIR/manifests/Brewfile"
