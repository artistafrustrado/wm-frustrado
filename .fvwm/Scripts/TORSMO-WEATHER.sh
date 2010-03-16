#!/bin/bash
# Gentil de Bortoli Júnior <gentiljunior@bortoli.com.br>
# Script para exibir o METAR no desktop.
# OBS.: Feito para ser utilizado em conjunto com o FVWM.
# Requisitos:torsmo
# Data: 15/05/2005.

# Por algum motivo que não pesquisei, a fonte
# que deve ser utilizada não está sendo lida do 
# arquivo de configuração e por isso ela está sendo
# informada explicitamente aqui.

CONFIG="${HOME}/.fvwm/.torsmorc-weather"
TORSMO="/usr/bin/torsmo"

${TORSMO} -c ${CONFIG} -f 6x10 2>&1 > /dev/null
