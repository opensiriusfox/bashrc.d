#!/bin/bash
export IFS=$'\n'

__builder_prebuild() {
	set -x
	ln -s logos/tachikoma-ref-b.png.sh ./logo.sh
}

__builder_postbuild() {
	set -x
	unlink logo.sh
}