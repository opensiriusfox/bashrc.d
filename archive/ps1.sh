#!/bin/bash

### Path Mangling Functions ####
function __currentDirTest() {
	if [[ $# -eq 1 ]]; then # normally just test active directory
		if [[ "$PWD" == "${1}"* ]]; then
			echo 1
		else
			echo 0
		fi
	else # this allows for testing directory suffixes
		DIR_LOC=$(echo "${PWD#${1}}" | cut -d/ -f1)
		if [[ "$DIR_LOC" == *"${2}"* ]]; then
			echo 1
		else
			echo 0
		fi
	fi
}

## Sorry, KDE user now. gvfs doesn't exist.
#function __smbGVFSReplace() {
#	local prefix_testing='/run/user/'$(id -u)'/gvfs/smb-share:server='
#	local gvfs_pfx='/run/user/'$(id -u)'/gvfs'
#	if [[ $(__currentDirTest "$HOME") -eq 1 ]]; then
#		echo $(__replacePathStr "$HOME" '\~')
#	elif [[ $(__currentDirTest $gvfs_pfx'/smb-share:server=') -eq 1 ]]; then
#		local smb_match='smb-share:server=\([^,]*\),share=\([^/,]\+\)'
#		if [[ $(__currentDirTest $gvfs_pfx'/smb-share:server=' ',user=') -eq 1 ]]; then
#			echo $(__replacePathStr $gvfs_pfx'/'$smb_match',user=\([^,/]*\)\([^/]*\)' 'gvfs:\1=>\3@\2')
#		else
#			echo $(__replacePathStr $gvfs_pfx'/'$smb_match 'gvfs:\1=>\2')
#		fi
#	else
#		echo $PWD
#	fi
#}

function __replacePathStr() {
	__SEARCH=$(echo "$1" | sed 's_/_\\/_g')
	__REPLACE=$(echo "$2" | sed 's_/_\\/_g')
	echo $PWD | sed "s/${__SEARCH}/${__REPLACE}/"
}


# Colored hostname special stuff for the Rem/Ram boxes
COLOR_RST='\[\e[39m\]'
ULINE='\[\e[4m\]'
ULINE_RST='\[\e[24m\]'


# Special Hostnames
if [[ "$(hostname)" == "Ram-the-Red" || "$(hostname)" == "Rem-the-Blue" ]]; then
	#  These get COLOR-normal-COLOR formating
	COLOR_RST_ESC='\\[\\033[39m\\]'
	if [[ "$(hostname)" == "Ram-the-Red" ]]; then
		COLOR='\\[\\033[31m\\]' # Ram Red
	else
		COLOR='\\[\\033[34m\\]' # Rem Blue
	fi
	alt_hostname="${ULINE}$(uname -n | sed "s_\(Ram\|Red\|Rem\|Blue\)_${COLOR}\1${COLOR_RST_ESC}_g")${ULINE_RST}"
elif [[ "$(hostname)" == "pino" ]]; then
	# Primitive COLOR hostnames
	COLOR_NORM='\[\e[35m\]' # Pino (purple)
	alt_hostname="${ULINE}${COLOR_NORM}$(uname -n)${COLOR_RST}${ULINE_RST}"
elif [[ "$(hostname)" == "Batou" ]]; then
	COLOR_NORM='\[\e[1;33m\]' # Batou (Yellow)
	alt_hostname="${ULINE}${COLOR_NORM}$(uname -n)${COLOR_RST}${ULINE_RST}"
else
	# And the rest of the plebs get Green.
	alt_hostname="\h"
fi

# Flip this flag to disable samba path substitution.
if [[ 1 -eq 1 ]]; then
	export PS1="\[\e[01;32m\]\u\[\e[00m\]@\[\e[01;32m\]${alt_hostname}"
	export PS1+="\[\e[01;34m\] \w \\$\[\e[00m\] "
else
	export PS1="\[\e[01;32m\]\u\[\e[00m\]@\[\e[01;32m\]${alt_hostname}"
	export PS1+="\[\e[01;34m\] \$(__smbGVFSReplace) \\$\[\e[00m\] "
fi


