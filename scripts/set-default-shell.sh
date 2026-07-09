#!/bin/sh

set -eu

zsh_path=$(command -v zsh)
if [ "$(uname -s)" = "Darwin" ]; then
  current_shell=$(dscl . -read "/Users/$(id -un)" UserShell 2>/dev/null | awk '{print $2}' || true)
else
  current_shell=$(getent passwd "$(id -un)" 2>/dev/null | awk -F: '{print $7}' || true)
fi

[ "$current_shell" = "$zsh_path" ] && exit 0
chsh -s "$zsh_path"
