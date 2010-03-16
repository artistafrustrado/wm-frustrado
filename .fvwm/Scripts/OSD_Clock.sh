#!/bin/bash
# Gentil de Bortoli Júnior <gentiljunior@bortoli.com.br>
# Script para exibir um relógio OSD no desktop.
# OBS.: Feito para ser utilizado em conjunto com o FVWM.
# Requisitos:osdclock xfonts-artwiz
# Data: 15/05/2005.

# Script baseado no clock.sh do Lyra <http://lyra.soueu.com.br>.

LOCK="/tmp/Clock.Lock"

if [ -f ${LOCK} ]; then
	rm -f ${LOCK}
	killall -9 osd_clock
else
	touch ${LOCK}
    osd_clock -f -artwiz-*-*-*-*-*-14-*-*-*-*-*-*-* -o -4 -r -c orange \
    -F "%d/%m %k:%M:%S                        " 2>&1 > /dev/null &
fi
