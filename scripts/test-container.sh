#!/bin/sh

set -eu

SCRIPT_DIR=$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)
# shellcheck source=lib.sh
. "$SCRIPT_DIR/lib.sh"

engine=${CONTAINER_ENGINE:-docker}
require_command "$engine"

"$engine" build \
  --tag dotfiles-bootstrap-test:devbox \
  --file "$REPO_DIR/test/ubuntu-devbox/Dockerfile" \
  "$REPO_DIR"

info "container bootstrap test passed"
