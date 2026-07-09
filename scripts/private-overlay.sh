#!/bin/sh

set -eu

SCRIPT_DIR=$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)
# shellcheck source=lib.sh
. "$SCRIPT_DIR/lib.sh"

load_profile

if [ ! -d "$PRIVATE_REPO_DIR/.git" ]; then
  info "cloning the private overlay"
  git clone "$PRIVATE_DOTFILES_REPO" "$PRIVATE_REPO_DIR"
fi

[ -d "$PRIVATE_SOURCE" ] || die "private overlay must contain a home/ chezmoi source directory"

identity="$CHEZMOI_CONFIG_DIR/key.txt"
if [ ! -s "$identity" ]; then
  require_command bw
  info "log in to and unlock Bitwarden to recover the shared age identity"
  status=$(bw status --raw)
  if [ "$status" = "unauthenticated" ]; then
    bw login
  fi
  BW_SESSION=${BW_SESSION:-$(bw unlock --raw)}
  export BW_SESSION
  umask 077
  mkdir -p "$CHEZMOI_CONFIG_DIR"
  bw get notes "${BW_AGE_ITEM:-dotfiles-age-identity}" >"$identity"
  chmod 600 "$identity"
fi

chezmoi_private apply --force
