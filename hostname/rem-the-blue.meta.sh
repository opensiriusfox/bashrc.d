#!/bin/bash
export IFS=$'\n'

__builder_prebuild() {
	set -x
	ln -s logos/rem-1b.png.sh ./logo.sh
}

__builder_postbuild() {
	set -x
	unlink logo.sh
}