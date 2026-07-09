#!/bin/sh

set -eu

REPO_DIR=$(CDPATH='' cd -- "$(dirname -- "$0")/.." && pwd)
XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-"$HOME/.config"}
XDG_DATA_HOME=${XDG_DATA_HOME:-"$HOME/.local/share"}
XDG_STATE_HOME=${XDG_STATE_HOME:-"$HOME/.local/state"}
CHEZMOI_CONFIG_DIR="$XDG_CONFIG_HOME/chezmoi"
CHEZMOI_CONFIG_FILE="$CHEZMOI_CONFIG_DIR/chezmoi.toml"
DOTFILES_STATE_DIR="$XDG_STATE_HOME/dotfiles"
PUBLIC_SOURCE="$REPO_DIR/home"
PRIVATE_REPO_DIR=${PRIVATE_DOTFILES_DIR:-"$XDG_DATA_HOME/dotfiles-private"}
PRIVATE_SOURCE="$PRIVATE_REPO_DIR/home"
PRIVATE_DOTFILES_REPO=${PRIVATE_DOTFILES_REPO:-"git@github.com:kevcenteno/dotfiles-private.git"}

export DOTFILES_STATE_DIR

die() {
  printf '%s\n' "error: $*" >&2
  exit 1
}

info() {
  printf '%s\n' "==> $*"
}

require_command() {
  command -v "$1" >/dev/null 2>&1 || die "required command not found: $1"
}

confirm() {
  prompt=$1
  if [ "${DOTFILES_ASSUME_YES:-0}" = "1" ]; then
    return 0
  fi
  printf '%s [y/N] ' "$prompt"
  read -r answer || return 1
  [ "$answer" = "y" ] || [ "$answer" = "Y" ]
}

is_desktop_profile() {
  [ "${DOTFILES_PROFILE:-}" = "personal" ] || [ "${DOTFILES_PROFILE:-}" = "work" ]
}

profile_from_config() {
  [ -f "$CHEZMOI_CONFIG_FILE" ] || return 1
  awk -F'"' '/^profile = / { print $2; exit }' "$CHEZMOI_CONFIG_FILE"
}

write_chezmoi_config() {
  profile=$1
  mkdir -p "$CHEZMOI_CONFIG_DIR"
  umask 077
  cat >"$CHEZMOI_CONFIG_FILE" <<EOF
encryption = "age"

[chezmoi]
sourceDir = "$PUBLIC_SOURCE"

[data]
profile = "$profile"

[age]
identity = "$CHEZMOI_CONFIG_DIR/key.txt"
EOF
  DOTFILES_PROFILE=$profile
  export DOTFILES_PROFILE
}

load_profile() {
  DOTFILES_PROFILE=${DOTFILES_PROFILE:-$(profile_from_config || true)}
  case "$DOTFILES_PROFILE" in
    personal|work|devbox) export DOTFILES_PROFILE ;;
    *) die "DOTFILES_PROFILE must be personal, work, or devbox" ;;
  esac
}

chezmoi_public() {
  chezmoi --source "$PUBLIC_SOURCE" "$@"
}

chezmoi_private() {
  chezmoi --source "$PRIVATE_SOURCE" "$@"
}
