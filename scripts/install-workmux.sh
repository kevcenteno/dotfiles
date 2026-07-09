#!/bin/sh

set -eu

WORKMUX_VERSION=0.1.213
destination="$HOME/.local/bin"

if command -v workmux >/dev/null 2>&1 && workmux --version | grep -q " $WORKMUX_VERSION$"; then
  exit 0
fi

case "$(uname -s):$(uname -m)" in
  Darwin:arm64) artifact=workmux-darwin-arm64 ;;
  Linux:x86_64) artifact=workmux-linux-amd64 ;;
  Linux:aarch64) artifact=workmux-linux-arm64 ;;
  *) printf '%s\n' "unsupported workmux platform: $(uname -s) $(uname -m)" >&2; exit 1 ;;
esac

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
base_url="https://github.com/raine/workmux/releases/download/v$WORKMUX_VERSION/$artifact"

curl --fail --location --proto '=https' --tlsv1.2 "$base_url.tar.gz" -o "$tmp/$artifact.tar.gz"
curl --fail --location --proto '=https' --tlsv1.2 "$base_url.sha256" -o "$tmp/$artifact.sha256"

(
  cd "$tmp"
  if command -v sha256sum >/dev/null 2>&1; then
    sha256sum --check "$artifact.sha256"
  else
    shasum --algorithm 256 --check "$artifact.sha256"
  fi
)

tar -xzf "$tmp/$artifact.tar.gz" -C "$tmp"
mkdir -p "$destination"
install -m 755 "$tmp/workmux" "$destination/workmux"
printf '%s\n' "installed workmux $WORKMUX_VERSION to $destination/workmux"
