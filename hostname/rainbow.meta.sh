#!/bin/bash
export IFS=$'\n'

__builder_prebuild() {
  NAME=$(hostname)
  OUTPUT_STRING="""$(
  for (( I=0; I < ${#NAME}; I++)); do
    printf '\\\[\e[38;5;%dm\\\]%s' $((${RANDOM}%224+8)) "${NAME:$I:1}"
  done
  )"""
  set -x
  sed 's/___ALT_HOSTNAME___/'${OUTPUT_STRING}'/' data/sd-template.sh > tmp-ps1.sh
	#ln -s logos/tachikoma-ref-b.png.sh ./logo.sh

  
}

__builder_postbuild() {
	set -x
	rm tmp-ps1.sh
}

