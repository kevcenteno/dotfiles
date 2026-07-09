#!/bin/sh

set -eu

SCRIPT_DIR=$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)
# shellcheck source=lib.sh
. "$SCRIPT_DIR/lib.sh"

load_profile
require_command chezmoi
chezmoi_public diff
if [ -d "$PRIVATE_SOURCE" ]; then
  chezmoi_private diff
fi
