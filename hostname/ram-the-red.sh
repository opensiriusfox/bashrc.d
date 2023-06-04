#!/bin/bash




COLOR_RST='\[\e[39m\]'
ULINE='\[\e[4m\]'
ULINE_RST='\[\e[24m\]'

COLOR_NORM='\[\e[31m\]' # Ram Red
alt_hostname="${ULINE}${COLOR_NORM}Ram${COLOR_RST}-the-${COLOR_NORM}Red${COLOR_RST}${ULINE_RST}"

export PS1="\[\e[01;32m\]\u\[\e[00m\]@\[\e[01;32m\]${alt_hostname}"
export PS1+="\[\e[01;34m\] \w \\$\[\e[00m\] "

unset $alt_hostname $COLOR_NORM $ULINE $ULINE_RST $COLOR_RST