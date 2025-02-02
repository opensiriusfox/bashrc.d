#!/bin/bash
################################################################################
# The first step is to try to remove the default aliases that I don't want
# to deal with. These are currently (as of Ubuntu 17.10) l, la, ll

function alias_exists() {
	SEARCH_KEY="$1"
	alias | cut -d= -f1 | cut -d\  -f2 | grep "^${SEARCH_KEY}\$" &>/dev/null
	return $?
}

# list of aliases to remove
__removeAliases=(l)

for __testAlias in ${__removeAliases[@]}; do
	if alias_exists "$__testAlias"; then
		unalias $__testAlias
	fi
done

# cleanup after ourselves
unset __removeAliases
unset __testAlias

################################################################################
alias fdiff="sdiff -t --tabsize=4 -w \$(tput cols) -b"
alias rsync-prog="rsync -Pav"
alias parallel="parallel --no-notice"

# Stopwatch
alias timer='echo "Timer started. Stop with Ctrl-D." && date && time cat && date'

# IP addresses
alias pubip="dig +short myip.opendns.com @resolver1.opendns.com"

if [[ "$(which ncdu 2>/dev/null)" ]]; then
	alias dush="ncdu --color dark -rr"
else
	alias dush="echo please 'apt install ncdu'"
fi

alias delcrush='zstd -T0 -19 --rm'
alias crush='zstd -T0 -19'

# Map python when available.
if ! which -s python && which -s python3; then
	alias python=python3
fi

function -restart_plasma() {
	(
		set -ex
		plasmashell --replace &>/dev/null &
		set +xe
		disown
	)
}
