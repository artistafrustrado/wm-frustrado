#!/bin/bash
# Gentil de Bortoli Júnior <gentiljunior@bortoli.com.br>
# Script para verificar se todos os programas
# necessários para o correto funcionamento da configuração
# descrita em ../.fvwm2rc estão presentes.
# Data: 15/05/2005.

# As "dependências" são lidas automaticamente do arquivo
# .fvwm2rc e dos Scripts contidos no diretório Scripts.

# To Do:
# - Fazer com que esse script possa ser usado em outras
#   distribuições que não sejam Debian.
# - Ler "install" ou "deinstall" da saída do DPKG.

I=0

# Certo. Eu sei que essa linha está terrível.
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
echo "Verificação de pacotes necessários para a configuração"
echo "do FVWM, com base no arquivo ../../.fvwm2rc e nos Scripts"
echo "contidos no diretório ../."
echo

if [ ${UID} != 0 ]; then
    echo -e "${RED}AVISO${NOCOLOR}"
    echo
    echo "Você não tem permissão para instalar pacotes."
    echo "Continuando..."
    echo
fi

echo -e "${WHITE}Total de Pacotes Necessários: ${#PACOTES[@]}${NOCOLOR}"
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
echo -e "${WHITE}Total de Pacotes Não Encontrados: ${J}${NOCOLOR}"
echo
echo "Comando:"
echo "aptitude install${FALTANDO}"
