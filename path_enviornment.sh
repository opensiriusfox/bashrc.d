#!/bin/bash
#####################################################################
# If we have a path element, strip it then add it in the new location
#####################################################################
function testDirPathStripAdd() {
	if [ -d "$1" ]; then
		pathStripAdd "$1"
	fi
}

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
# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
	pathStripAdd "$HOME/bin" front
fi
if [ -d "$HOME/.bin" ] ; then
	pathStripAdd "$HOME/.bin" front
fi

# And load the local directory
if [ -d "$HOME/.local" ] ; then
	loadDirectory "$HOME/.local" front
	# Set the data directory
	if [ -d "$HOME/.local/share" ] ; then
		export XDG_DATA_HOME="$HOME/.local/share"
	fi
fi

# Load information that is in any extra random installed directory.
__LOAD_DIRS=(/opt/mate /opt/makemkv /opt/ffmpeg $HOME/.gem/ruby/2.5.0 /opt/icestorm)
for DIR_EXPAND in ${__LOAD_DIRS[*]}
do
	loadDirectory $DIR_EXPAND
done
unset DIR_EXPAND __LOAD_DIRS

echo $PKG_CONFIG_PATH
echo $LD_RUN_PATH
echo $LD_LIBRARY_PATH
# CLEAN these variables
__VAR_PTR_LST=(PKG_CONFIG_PATH LD_RUN_PATH LD_LIBRARY_PATH)
for __VAR_PTR in ${__VAR_PTR_LST[*]}
do
	# get the value in the pointer
	eval __VAR_VAL=\$$__VAR_PTR
	if [ ${#__VAR_VAL} -gt 0 ]; then
		# Strip ending : or leading : if exists.
		if [ ${__VAR_VAL: -1} == ":" ]; then
			__VAR_VAL=${__VAR_VAL:0:-1}
		fi
		if [ ${__VAR_VAL:0:1} == ":" ]; then
			__VAR_VAL=${__VAR_VAL:1}
		fi
		while [[ $__VAR_VAL == *"::"* ]]; do
			__VAR_VAL=${__VAR_VAL/::/:}
		done
		while [[ $__VAR_VAL == *"/:"* ]]; do
			__VAR_VAL=${__VAR_VAL/\/:/:}
		done
		# save the cleaned result
		eval $__VAR_PTR=$__VAR_VAL
		#echo $__VAR_PTR "=" $__VAR_VAL
	fi
done
unset __VAR_PTR_LST __VAR_PTR __VAR_VAL

