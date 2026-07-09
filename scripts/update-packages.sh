#!/bin/sh

set -eu

SCRIPT_DIR=$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)
# shellcheck source=lib.sh
. "$SCRIPT_DIR/lib.sh"

load_profile
confirm "Upgrade declared system packages?" || exit 0

case "$(uname -s)" in
  Darwin) brew upgrade ;;
  Linux)
    sudo apt-get update
    sudo apt-get upgrade -y
    ;;
  *) die "unsupported operating system: $(uname -s)" ;;
esac
