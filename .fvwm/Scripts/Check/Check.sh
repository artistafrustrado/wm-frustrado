#!/bin/bash
# Gentil de Bortoli J�nior <gentiljunior@bortoli.com.br>
# Script para verificar se todos os programas
# necess�rios para o correto funcionamento da configura��o
# descrita em ../.fvwm2rc est�o presentes.
# Data: 15/05/2005.

# As "depend�ncias" s�o lidas automaticamente do arquivo
# .fvwm2rc e dos Scripts contidos no diret�rio Scripts.

# To Do:
# - Fazer com que esse script possa ser usado em outras
#   distribui��es que n�o sejam Debian.
# - Ler "install" ou "deinstall" da sa�da do DPKG.

I=0

# Certo. Eu sei que essa linha est� terr�vel.
# Outra hora eu penso numa forma inteligente de fazer isso.
FIND="(sed -n '/^#I$/,/^#F$/p' ../../.fvwm2rc | egrep -v '#I|#F' | tr -d '#' ; \
      grep -h Requisitos ../*.sh | cut -d : -f 2) | tr -s ' ' '\n' | sort -u"

for REQUISITO in `eval ${FIND}`; do
    PACOTES[${I}]="${REQUISITO}"
    let I++
done

NOCOLOR="\033[0m"
WHITE="\033[37;1m"
GREEN="\033[32;1m"
RED="\033[31;1m"

clear
echo "Verifica��o de pacotes necess�rios para a configura��o"
echo "do FVWM, com base no arquivo ../../.fvwm2rc e nos Scripts"
echo "contidos no diret�rio ../."
echo

if [ ${UID} != 0 ]; then
    echo -e "${RED}AVISO${NOCOLOR}"
    echo
    echo "Voc� n�o tem permiss�o para instalar pacotes."
    echo "Continuando..."
    echo
fi

echo -e "${WHITE}Total de Pacotes Necess�rios: ${#PACOTES[@]}${NOCOLOR}"
echo

for I in `seq 0 $((${#PACOTES[@]}-1))`; do
    if dpkg -p ${PACOTES[${I}]} > /dev/null 2> /dev/null; then
        printf "%-18s\t[ ${GREEN}OK${NOCOLOR} ]\n" ${PACOTES[${I}]}
    else
        FALTANDO="${FALTANDO} ${PACOTES[${I}]}"
        printf "%-18s\t[ ${RED}NE${NOCOLOR} ]\n" ${PACOTES[${I}]}
        let J++
    fi
done

echo
echo -e "${WHITE}Total de Pacotes N�o Encontrados: ${J}${NOCOLOR}"
echo
echo "Comando:"
echo "aptitude install${FALTANDO}"
