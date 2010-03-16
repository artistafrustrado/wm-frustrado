#!/bin/bash
# Gentil de Bortoli Júnior <gentiljunior@bortoli.com.br>
# Script para exibir um calendário no desktop.
# OBS.: Feito para ser utilizado em conjunto com o FVWM.
# Requisitos:xdkcal xfonts-artwiz
# Data: 15/05/2005.

# Script baseado no clock.sh do Lyra <http://lyra.soueu.com.br>.

XDKCAL="/usr/bin/X11/xdkcal"
XWININFO="/usr/bin/X11/xwininfo"

HEIGHT=`${XWININFO} -root | grep Height | cut -d : -f2 | tr -d " "`

case ${HEIGHT} in
    768   ) OFFSET=615 ;;
    1024  ) OFFSET=870 ;;
    *     ) OFFSET=615 ;;
esac

LOCK="/tmp/Calendar.Lock"

if [ -f ${LOCK} ]; then
	rm -f ${LOCK}
	killall -9 ${XDKCAL}
else
	touch ${LOCK}
    ${XDKCAL} -y ${OFFSET} -f -artwiz-*-*-*-*-*-14-*-*-*-*-*-*-* -C green \
    -H green -S green -T orange -M orange -s 0 -m on -w on -p 5 \
    -t off -n 2 -N 2>&1 > /dev/null &
fi
