#!/bin/bash

export PS1="\[\e[01;32m\]\u\[\e[00m\]@\[\e[01;32m\]___ALT_HOSTNAME___"
export PS1+="\[\e[01;34m\] \w \\$\[\e[00m\] "

unset $alt_hostname $COLOR_NORM $ULINE $ULINE_RST $COLOR_RST
