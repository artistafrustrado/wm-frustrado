#!/bin/bash
# Gentil de Bortoli Júnior <gentiljunior@bortoli.com.br>
# Script para remover os arquivos de histórico do CenterICQ.
# OBS.: Feito para ser utilizado em conjunto com o FVWM.
# Requisitos:xosd-bin
# Data: 15/05/2005.

CENTERICQ="${HOME}/.centericq"

if [ ! -d ${CENTERICQ} ]; then
    MSG="Diretório Não Encontrado"
    COR="yellow"
else
    find ${CENTERICQ} -type f -name history -exec rm -f {} \;
    if [ $? == 0 ]; then
        MSG="Histórico Removido"
        COR="green"
    else
        MSG="Erro"
        COR="red"
    fi
fi

HEIGHT=`xwininfo -root | grep Height | cut -d : -f2 | tr -d " "`

case ${HEIGHT} in
    768   ) OFFSET=760  ;;
    1024  ) OFFSET=1015 ;;
    *     ) OFFSET=760  ;;
esac

echo ${MSG} | osd_cat --delay=1 --align=center --offset=${OFFSET} -c ${COR} -f 6x10
