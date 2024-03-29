#!/bin/bash
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus

COLOR_RST='\[\e[39m\]'
ULINE='\[\e[4m\]'
ULINE_RST='\[\e[24m\]'


alt_hostname="\h"

export PS1="\[\e[01;32m\]\u\[\e[00m\]@\[\e[01;32m\]${alt_hostname}"
export PS1+="\[\e[01;34m\] \w \\$\[\e[00m\] "

unset $alt_hostname $COLOR_NORM $ULINE $ULINE_RST $COLOR_RST