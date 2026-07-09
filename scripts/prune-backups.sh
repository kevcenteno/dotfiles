#!/bin/sh

set -eu

SCRIPT_DIR=$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)
# shellcheck source=lib.sh
. "$SCRIPT_DIR/lib.sh"

backup_root="$DOTFILES_STATE_DIR/backups"
[ -d "$backup_root" ] || exit 0
find "$backup_root" -mindepth 1 -maxdepth 1 -type d -mtime +30 -exec rm -rf {} +
