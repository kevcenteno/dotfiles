#!/bin/sh

set -eu

REPO_DIR=$(CDPATH='' cd -- "$(dirname -- "$0")/.." && pwd)
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

mkdir -p "$tmp/config" "$tmp/data" "$tmp/state"
ln -s "$REPO_DIR/home/dot_config/nvim" "$tmp/config/nvim"

XDG_CONFIG_HOME="$tmp/config" XDG_DATA_HOME="$tmp/data" XDG_STATE_HOME="$tmp/state" \
  nvim --headless '+Lazy! restore' \
  "+lua require('lazy').load({ plugins = { 'mason-lspconfig.nvim', 'blink.cmp', 'copilot.lua' } })" \
  "+lua assert(require('blink.cmp'))" +qa
