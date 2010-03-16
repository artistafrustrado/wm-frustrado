#!/bin/bash
# Gentil de Bortoli Júnior <gentiljunior@bortoli.com.br>
# Script para exibir um monitor de hardware no desktop.
# OBS.: Feito para ser utilizado em conjunto com o FVWM.
# Requisitos:torsmo
# Data: 15/05/2005.

# Por algum motivo que não pesquisei, a fonte
# que deve ser utilizada não está sendo lida do 
# arquivo de configuração e por isso ela está sendo
# informada explicitamente aqui.

# Adaptação por Breno Moiana <breno.moiana@gmail.com>

CONFIG="${HOME}/.fvwm/.torsmorc-tdl"
TORSMO="/usr/bin/torsmo"

${TORSMO} -c ${CONFIG} -x 3 -y 210 -f 6x10 2>&1 > /dev/null
