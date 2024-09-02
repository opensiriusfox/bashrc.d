#!/bin/bash
#####################################################################
# If we have a path element, strip it then add it in the new location
#####################################################################
function pathStripAdd() {
	pathStrip "$1"
	if [[ "$2" == "front" ]]; then
		export PATH="${1}":"$PATH"
	else
		export PATH="$PATH":"${1}"
	fi
}

function pathStrip() {
	unset PATH2
	# Iterate through each item of path.
	# Keep items if they don't match argument $1
	for p in ${PATH//:/ }; do
		if [[ $p != *$1* ]] ; then
			PATH2="${PATH2:-}":"$p"
			#echo $PATH2
		fi
	done
	export PATH="${PATH2:1}"
	unset PATH2
}

#####################################################################
# A function to load enviornment variables 
#####################################################################
function loadBinDir() {
	DIR_EXPAND=$(readlink -f "$1")
	if [ -d "$DIR_EXPAND"]; then
		pathSTripAdd "$DIR_EXPAND/bin" "$2"
	fi
}

function loadDirectory() {
	DIR_EXPAND=$(readlink -f "$1")
	if [ -d "$DIR_EXPAND" ] ; then
		if [ -d "$DIR_EXPAND/bin" ] ; then
			pathStripAdd "$DIR_EXPAND/bin" "$2"
		fi
		if [ -d "$DIR_EXPAND/lib" ] ; then
			export LD_RUN_PATH="$DIR_EXPAND/lib:$LD_RUN_PATH"
			export LD_LIBRARY_PATH="$DIR_EXPAND/lib:$LD_LIBRARY_PATH"

			if [ -d "$DIR_EXPAND/lib/pkgconfig" ] ; then
				export PKG_CONFIG_PATH="$DIR_EXPAND/lib/pkgconfig:$PKG_CONFIG_PATH"
			fi
		fi
		if [ -d "$DIR_EXPAND/share/pkgconfig" ] ; then
			export PKG_CONFIG_PATH="$DIR_EXPAND/share/pkgconfig:$PKG_CONFIG_PATH"
		fi
		if [ -d "$DIR_EXPAND/share/aclocal" ] ; then
			export ACLOCAL_FLAGS="-I $DIR_EXPAND/share/aclocal $ACLOCAL_FLAGS"
		fi
	fi
}


###########
# Load information that is in any extra random installed directory.
__LOAD_DIRS=(
	/opt/makemkv
	$HOME/.local/share/gem/ruby/3.0.0
)
for DIR_EXPAND in ${__LOAD_DIRS[@]}; do
	loadDirectory $DIR_EXPAND
done
unset DIR_EXPAND __LOAD_DIRS

# set PATH so it includes user's private bin if it exists
__LOAD_PATHS=(
	"$HOME/bin"
	"$HOME/.bin"
	/opt/oss-cad-suite/bin
)
for DIR_EXPAND in ${__LOAD_PATHS[@]}; do
	pathStripAdd "$DIR_EXPAND" front
done
unset DIR_EXPAND __LOAD_PATHS

# And load the local directory
if [ -d "$HOME/.local" ] ; then
	loadDirectory "$HOME/.local" front
	# Set the data directory
	if [ -d "$HOME/.local/share" ] ; then
		export XDG_DATA_HOME="$HOME/.local/share"
	fi
fi

unset pathStripAdd pathStrip loadDirectory

###########
# If rust is a thing, load it
if [[ -d "$HOME/.cargo" ]]; then
	[[ -r "$HOME/.cargo/env" ]] && (
		source "$HOME/.cargo/env"
	)
fi
