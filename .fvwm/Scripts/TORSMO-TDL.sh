#!/bin/bash
# Gentil de Bortoli J�nior <gentiljunior@bortoli.com.br>
# Script para exibir um monitor de hardware no desktop.
# OBS.: Feito para ser utilizado em conjunto com o FVWM.
# Requisitos:torsmo
# Data: 15/05/2005.

# Por algum motivo que n�o pesquisei, a fonte
# que deve ser utilizada n�o est� sendo lida do 
# arquivo de configura��o e por isso ela est� sendo
# informada explicitamente aqui.

# Adapta��o por Breno Moiana <breno.moiana@gmail.com>

CONFIG="${HOME}/.fvwm/.torsmorc-tdl"
TORSMO="/usr/bin/torsmo"

${TORSMO} -c ${CONFIG} -x 3 -y 210 -f 6x10 2>&1 > /dev/null
