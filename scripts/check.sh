#!/bin/sh

set -eu

SCRIPT_DIR=$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)
# shellcheck source=lib.sh
. "$SCRIPT_DIR/lib.sh"

for script in "$REPO_DIR"/bootstrap "$REPO_DIR"/scripts/*.sh; do
  sh -n "$script"
done

if command -v shellcheck >/dev/null 2>&1; then
  shellcheck --exclude=SC1091 --shell=sh "$REPO_DIR"/bootstrap "$REPO_DIR"/scripts/*.sh
fi

if command -v chezmoi >/dev/null 2>&1; then
  "$SCRIPT_DIR/check-chezmoi.sh"
fi

if command -v nvim >/dev/null 2>&1; then
  nvim --headless --clean \
    "+lua assert(loadfile('$REPO_DIR/home/dot_config/nvim/init.lua'))" +qa
fi
