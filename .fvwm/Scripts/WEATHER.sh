#!/bin/sh
# Script para recuperar o METAR ou TAF de um aer�dromo
# brasileiro atrav�s da REDEMET - Rede de Meteorologia
# do Comando da Aeron�utica - http://www.redemet.aer.mil.br.
#
# Data de cria��o: 07/07/2005
# �ltima modifica��o: 07/07/2005
# Vers�o: 1.0
#
# Copyright (C) 2005 Gentil de Bortoli J�nior <gentiljunior@bortoli.com.br>
# Licenciado sob os termos da GNU/GPL vers�o 2, conforme
# http://www.gnu.org/copyleft/gpl.html.

# To Do:
# - Usar GETOPTS.
# - Consultar v�rias localidades ao mesmo tempo.
# - Consultar dentro de intervalos de tempo determinados.

if [ "${#}" -lt 2 ]; then
    echo "Uso: ${0} <Mensagem> <Indicador de Localidade>"
    echo "Exemplo: ${0} TAF SBBI"
    exit 1
fi

# Programas utilizados.

LYNX="/usr/bin/lynx"
GREP="/bin/grep"
TR="/usr/bin/tr"

# Tipo da mensagem.
# Essa convers�o � feita para permitir que os par�metros
# possam ser digitados de qualquer forma.

MSG=$(echo ${1} | ${TR} "[:upper:]" "[:lower:]")

# Localidade.

LOCAL=$(echo ${2} | ${TR} "[:lower:]" "[:upper:]")

# Script para onde os dados ser�o postados.

ACTION="http://www.redemet.aer.mil.br/consulta_resultado.php"

# Vari�veis que ser�o postadas.

PG_ATU="pg_atu=0"
PG_FIM="pg_fim=0"

TIPO_MSG="tipo_msg=${MSG}"
LOCALIDADE_SIM="localidade_sim=sim"
LOCALIDADES="localidades=${LOCAL}"

# Vari�veis com valor padr�o.

GRUPO_SIM="grupo_sim="
GRUPO="grupo="

DATA_INI="data_ini="
HORA_INI="hora_ini="
DATA_FIM="data_fim="
HORA_FIM="hora_fim="
MAX_LINHA="max_linha="

METAR=$(echo "${PG_ATU}&${PG_FIM}&${TIPO_MSG}&${LOCALIDADE_SIM}&${LOCALIDADES}" \
| ${LYNX} -post-data ${ACTION} \
| ${GREP} ${LOCAL})

echo ${METAR}
