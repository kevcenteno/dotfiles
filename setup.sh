#!/bin/bash

platform=$(uname);

if [ $platform = 'Linux' ]; then
  sh ./linux-setup.sh
elif [ $platform = 'Darwin' ]; then
  sh ./mac-setup.sh
fi
