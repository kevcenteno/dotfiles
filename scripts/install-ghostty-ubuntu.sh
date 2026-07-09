#!/bin/sh

set -eu

if command -v ghostty >/dev/null 2>&1; then
  exit 0
fi

if apt-cache show ghostty >/dev/null 2>&1; then
  sudo apt-get install -y ghostty
  exit 0
fi

command -v add-apt-repository >/dev/null 2>&1 || {
  sudo apt-get install -y software-properties-common
}

printf '%s\n' "Ghostty is not in this Ubuntu release's default repositories."
printf '%s\n' "Adding the community-maintained mkasberg/ghostty-ubuntu PPA."
sudo add-apt-repository -y ppa:mkasberg/ghostty-ubuntu
sudo apt-get update
sudo apt-get install -y ghostty
