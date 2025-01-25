#!/bin/bash


## Node
#
# echo 'prefix = ~/.node' > ~/.npmrc
#
if [[ -d ~/.node ]]; then
  if [[ -d ~/.node/bin ]]; then
    export PATH="$HOME/.node/bin:$PATH"
  fi
  export NODE_PATH="$HOME/.node/lib/node_modules:$NODE_PATH"

fi

## Express IDF for ESP32s
if [[ -e "/opt/esp32/esp-idf" ]]; then
	export IDF_TOOLS_PATH=/opt/esp32/expressif
	alias get_idf='. /opt/esp32/esp-idf/export.sh'
fi
