#!/bin/bash
# Gentil de Bortoli Júnior <gentiljunior@bortoli.com.br>
# Script para exibir logs no desktop.
# OBS.: Feito para ser utilizado em conjunto com o FVWM.
# Requisitos:root-tail
# Data: 15/05/2005.

#/var/log/xferlog,yellow \
#/var/log/exim4/mainlog,orange \

ROOT_TAIL="/usr/bin/root-tail"

ARQUIVOS="/var/log/apache2/access.log,white \
/var/log/apache2/error.log,orange \
/var/log/php5-apache.log,blue \
/var/log/auth.log,green \
/var/log/messages,red"

for ARQUIVO in ${ARQUIVOS}; do
    NOME=`echo ${ARQUIVO} | cut -d "," -f1`
    if [ -f ${NOME} ]; then
        if [ -r ${NOME} ]; then
            OK="${OK} ${ARQUIVO}"
        else
            echo "${NOME} Sem Permissão"
        fi
    else
        echo "${NOME} Não Existe"
    fi
done

# --frame
${ROOT_TAIL} -f -g 1000x550+0+100 -fn 6x10 ${OK} 2>&1 > /dev/null
