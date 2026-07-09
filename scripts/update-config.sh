#!/bin/sh

set -eu

SCRIPT_DIR=$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)
# shellcheck source=lib.sh
. "$SCRIPT_DIR/lib.sh"

confirm "Pull and apply public and private dotfile changes?" || exit 0
git -C "$REPO_DIR" pull --ff-only
if [ -d "$PRIVATE_REPO_DIR/.git" ]; then
  git -C "$PRIVATE_REPO_DIR" pull --ff-only
fi
"$SCRIPT_DIR/apply.sh"
