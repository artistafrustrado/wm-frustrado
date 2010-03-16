#!/bin/sh
# Script para recuperar o METAR ou TAF de um aeródromo
# brasileiro através da REDEMET - Rede de Meteorologia
# do Comando da Aeronáutica - http://www.redemet.aer.mil.br.
#
# Data de criação: 07/07/2005
# Última modificação: 07/07/2005
# Versão: 1.0
#
# Copyright (C) 2005 Gentil de Bortoli Júnior <gentiljunior@bortoli.com.br>
# Licenciado sob os termos da GNU/GPL versão 2, conforme
# http://www.gnu.org/copyleft/gpl.html.

# To Do:
# - Usar GETOPTS.
# - Consultar várias localidades ao mesmo tempo.
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
# Essa conversão é feita para permitir que os parâmetros
# possam ser digitados de qualquer forma.

MSG=$(echo ${1} | ${TR} "[:upper:]" "[:lower:]")

# Localidade.

LOCAL=$(echo ${2} | ${TR} "[:lower:]" "[:upper:]")

# Script para onde os dados serão postados.

ACTION="http://www.redemet.aer.mil.br/consulta_resultado.php"

# Variáveis que serão postadas.

PG_ATU="pg_atu=0"
PG_FIM="pg_fim=0"

TIPO_MSG="tipo_msg=${MSG}"
LOCALIDADE_SIM="localidade_sim=sim"
LOCALIDADES="localidades=${LOCAL}"

# Variáveis com valor padrão.

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
