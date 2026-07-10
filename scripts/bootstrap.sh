#!/bin/sh

set -eu

SCRIPT_DIR=$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)
# shellcheck source=lib.sh
. "$SCRIPT_DIR/lib.sh"

choose_profile() {
  if [ -n "${DOTFILES_PROFILE:-}" ]; then
    return
  fi
  printf '%s\n' "Choose a profile: personal, work, or devbox"
  printf '> '
  read -r DOTFILES_PROFILE
  export DOTFILES_PROFILE
}

backup_if_first_install() {
  marker="$DOTFILES_STATE_DIR/public-installed"
  [ -e "$marker" ] && return
  "$SCRIPT_DIR/backup-existing.sh"
}

choose_profile
load_profile

case "$(uname -s)" in
  Darwin) "$SCRIPT_DIR/provision-macos.sh" ;;
  Linux) "$SCRIPT_DIR/provision-ubuntu.sh" ;;
  *) die "unsupported operating system: $(uname -s)" ;;
esac

require_command mise
mise trust "$REPO_DIR/mise.toml"
mise install chezmoi
chezmoi_dir="$(mise where chezmoi)"
export PATH="$chezmoi_dir:$PATH"
require_command chezmoi
write_chezmoi_config "$DOTFILES_PROFILE"
backup_if_first_install
"$SCRIPT_DIR/install-oh-my-zsh.sh"
chezmoi_public apply --force
mkdir -p "$DOTFILES_STATE_DIR"
touch "$DOTFILES_STATE_DIR/public-installed"

mise install
mise reshim --force
"$SCRIPT_DIR/install-workmux.sh"
"$SCRIPT_DIR/private-overlay.sh"
"$SCRIPT_DIR/set-default-shell.sh"

info "bootstrap complete"
