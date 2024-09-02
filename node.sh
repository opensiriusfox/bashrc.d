#!/bin/bash

#
# echo 'prefix = ~/.node' > ~/.npmrc
#

if [[ -d ~/.node ]]; then
  if [[ -d ~/.node/bin ]]; then
    export PATH="$HOME/.node/bin:$PATH"
  fi
  export NODE_PATH="$HOME/.node/lib/node_modules:$NODE_PATH"

fi
