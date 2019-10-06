#!/bin/bash

# random things I don't know how to sort
complete -cf sudo

# Include the autojump tool if it exists
if [[ -e /usr/share/autojump/autojump.sh ]]; then
	. /usr/share/autojump/autojump.sh
fi

export LESS=R # colorize less output if we use a pipe
HISTSIZE=2000
HISTFILESIZE=10000

