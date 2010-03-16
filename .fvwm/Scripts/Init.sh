#!/bin/bash

setup_screens()
{
	if $(xrandr -q| grep 'DVI' > /dev/null); then echo "IS CONNECTED"; xrandr --output DVI-0 --auto --left-of VGA-0 ;fi
}

#setup_screens
xchat &
pidgin &
wicd-client &
nitrogen --restore &
