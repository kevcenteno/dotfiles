#!/bin/sh

set -eu

SCRIPT_DIR=$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)
# shellcheck source=lib.sh
. "$SCRIPT_DIR/lib.sh"

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

for profile in personal work devbox; do
  config_home="$tmp/$profile/config"
  home_dir="$tmp/$profile/home"
  mkdir -p "$config_home/chezmoi" "$home_dir"
  printf 'encryption = "age"\n\n[data]\nprofile = "%s"\n\n[age]\nidentity = "%s/key.txt"\n' \
    "$profile" "$config_home/chezmoi" >"$config_home/chezmoi/chezmoi.toml"
  HOME="$home_dir" XDG_CONFIG_HOME="$config_home" chezmoi --source "$PUBLIC_SOURCE" apply --dry-run --force
  if [ "$profile" = "devbox" ] && HOME="$home_dir" XDG_CONFIG_HOME="$config_home" \
    chezmoi --source "$PUBLIC_SOURCE" managed | grep -qx '.config/ghostty/config'; then
    die "devbox must not manage Ghostty"
  fi
done
