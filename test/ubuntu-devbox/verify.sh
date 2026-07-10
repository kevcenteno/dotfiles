#!/bin/sh

set -eu

XDG_DATA_HOME=${XDG_DATA_HOME:-"$HOME/.local/share"}
export PATH="$XDG_DATA_HOME/mise/shims:$HOME/.local/bin:$PATH"

require_file() {
  [ -f "$1" ] || {
    printf '%s\n' "missing expected file: $1" >&2
    exit 1
  }
}

require_command() {
  command -v "$1" >/dev/null 2>&1 || {
    printf '%s\n' "missing expected command: $1" >&2
    exit 1
  }
}

require_absent() {
  [ ! -e "$1" ] && [ ! -L "$1" ] || {
    printf '%s\n' "expected path to be absent: $1" >&2
    exit 1
  }
}

require_file "$HOME/.config/chezmoi/chezmoi.toml"
require_file "$HOME/.local/state/dotfiles/public-installed"
require_file "$HOME/.zshrc"
require_file "$HOME/.gitconfig"
require_file "$HOME/.gitignore"
require_file "$HOME/.tmux.conf"
require_file "$HOME/.config/nvim/init.lua"
require_file "$HOME/.config/workmux/config.yaml"

for command in chezmoi git mise nvim tmux tree-sitter workmux zsh; do
  require_command "$command"
done

tree-sitter --version

if [ -e "$HOME/.config/ghostty/config" ]; then
  printf '%s\n' 'Ghostty must not be managed for the devbox profile' >&2
  exit 1
fi

grep -qx 'profile = "devbox"' "$HOME/.config/chezmoi/chezmoi.toml"
grep -qx 'export EDITOR=nvim' "$HOME/.zshrc"

backup=$(find "$HOME/.local/state/dotfiles/backups" -mindepth 1 -maxdepth 1 -type d -print -quit)
[ -n "$backup" ] || {
  printf '%s\n' 'missing dotfile migration backup' >&2
  exit 1
}

for path in .gitconfig .vimrc .vim .wezterm.lua .z.sh; do
  [ ! -L "$backup/$path" ] || {
    printf '%s\n' "backup must not preserve a symlink: $path" >&2
    exit 1
  }
done

rm -rf /legacy
grep -qx 'name = old-gitconfig' "$backup/.gitconfig"
grep -qx 'legacy vimrc' "$backup/.vimrc"
grep -qx 'legacy vim directory' "$backup/.vim/marker"
grep -qx 'legacy wezterm' "$backup/.wezterm.lua"
grep -qx 'legacy z.sh' "$backup/.z.sh"

require_absent "$HOME/.vimrc"
require_absent "$HOME/.vim"
require_absent "$HOME/.wezterm.lua"
require_absent "$HOME/.z.sh"
[ ! -L "$HOME/.gitconfig" ]
grep -q '^\[core\]' "$HOME/.gitconfig"

cd /workspace
mise run check
