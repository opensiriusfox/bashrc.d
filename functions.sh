#!/bin/bash
sumList() { SIZE=$(ls -FaGl "${@}" | awk '{ total += $4 }; END { print total }'); echo $(($SIZE/1024)); }

# Simple calculator
calc() {
	local result=""
	result="$(printf "scale=10;%s\\n" "$*" | bc --mathlib | tr -d '\\\n')"
	#						└─ default (when `--mathlib` is used) is 20

	if [[ "$result" == *.* ]]; then
		# improve the output for decimal numbers
		# add "0" for cases like ".5"
		# add "0" for cases like "-.5"
		# remove trailing zeros
		printf "%s" "$result" |
			sed -e 's/^\./0./'  \
			-e 's/^-\./-0./' \
			-e 's/0*$//;s/\.$//'
	else
		printf "%s" "$result"
	fi
	printf "\\n"
}

# Create a data URL from a file
dataurl() {
	local mimeType
	mimeType=$(file -b --mime-type "$1")
	if [[ $mimeType == text/* ]]; then
		mimeType="${mimeType};charset=utf-8"
	fi
	echo "data:${mimeType};base64,$(openssl base64 -in "$1" | tr -d '\n')"
}

# Run `dig` and display the most useful info
digga() {
	dig +nocmd "$1" any +multiline +noall +answer
}

# UTF-8-encode a string of Unicode symbols
escape() {
	local args
	mapfile -t args < <(printf "%s" "$*" | xxd -p -c1 -u)
	printf "\\\\x%s" "${args[@]}"
	# print a newline unless we’re piping the output to another program
	if [ -t 1 ]; then
		echo ""; # newline
	fi
}

# Decode \x{ABCD}-style Unicode escape sequences
unidecode() {
	perl -e "binmode(STDOUT, ':utf8'); print \"$*\""
	# print a newline unless we’re piping the output to another program
	if [ -t 1 ]; then
		echo ""; # newline
	fi
}

# Get a character’s Unicode code point
codepoint() {
	perl -e "use utf8; print sprintf('U+%04X', ord(\"$*\"))"
	# print a newline unless we’re piping the output to another program
	if [ -t 1 ]; then
		echo ""; # newline
	fi
}

# Get colors in manual pages
man() {
	env \
		LESS_TERMCAP_mb="$(printf '\e[1;31m')" \
		LESS_TERMCAP_md="$(printf '\e[1;31m')" \
		LESS_TERMCAP_me="$(printf '\e[0m')" \
		LESS_TERMCAP_se="$(printf '\e[0m')" \
		LESS_TERMCAP_so="$(printf '\e[1;44;33m')" \
		LESS_TERMCAP_ue="$(printf '\e[0m')" \
		LESS_TERMCAP_us="$(printf '\e[1;32m')" \
		man "$@"
}

# a tool to test if a given date has passed
# give it any standard date string (next Fri, 4:19pm, etc.) and it returns
# a boolan if we are less than that date. Use to loop functions.
dateTest() {
	[[ $(date +"%s" --date="$1") -gt $(date +"%s") ]]
}

# Test if a PID is running
pidTest() {
	ps -p $1 &>/dev/null
	[[ $? -eq 0 ]];
}

# Call 'tree' but pipe it through LS with color preservation
treep() { # short for tree pager
	if [[ $# -gt 0 ]]; then
		tree -C $* | less
	else
		tree -C | less
	fi
}

function rv() {
	RV=$?
	if [[ $RV -eq 0 ]]; then
		COLOR='2'
	elif [[ $RV -eq 1 ]]; then
		COLOR='3'
	else
		COLOR='1'
	fi
	printf '\e[4%dm' $COLOR
	printf ' RV=%d \e[0m\n' $RV >&2
}

function hexy() {
	python3 -c 'import sys
for v in sys.argv[1:]:
  print("{:02x}".format(int(v)), end="")
print("")
' $*
}
