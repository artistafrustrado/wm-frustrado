#!/bin/bash
# Gentil de Bortoli Júnior <gentiljunior@bortoli.com.br>
# Script para notificar o processo de travamento automático do X.
# OBS.: Feito para ser utilizado em conjunto com o script XAutoLock.sh.
# Requisitos:xosd-bin beep
# Data: 15/05/2005.

MSG=${1}
OFFSET=${2}

beep -f 4000 -r 3 -l 30 &
echo ${MSG} | /usr/bin/osd_cat --delay=5 --align=center --offset=${OFFSET} -f 6x10
