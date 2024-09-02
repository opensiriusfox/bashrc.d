#!/bin/bash

# random things I don't know how to sort
complete -cf sudo

# Include the autojump tool if it exists
if [[ -e /usr/share/autojump/autojump.sh ]]; then
	. /usr/share/autojump/autojump.sh
fi

export LESS=RF	# colorize less output if we use a pipe 
				# quit automatically if we only have one screen of stuff
				# 
export HISTSIZE=10000
export HISTFILESIZE=20000



export HISTIGNORE='pwd:exit:fg:bg:top:clear:history:ls:uptime:df'
