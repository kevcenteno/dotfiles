#!/bin/sh

set -eu

SCRIPT_DIR=$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)
# shellcheck source=lib.sh
. "$SCRIPT_DIR/lib.sh"

load_profile
require_command chezmoi
chezmoi_public apply
if [ -d "$PRIVATE_SOURCE" ]; then
  "$SCRIPT_DIR/private-overlay.sh"
fi
