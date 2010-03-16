#!/bin/bash
# Gentil de Bortoli Júnior <gentiljunior@bortoli.com.br>
# Script para tirar uma ScreenShot e solicitar o nome com o 
# o qual o arquivo deverá ser gravado.
# OBS.: Feito para ser utilizado em conjunto com o FVWM.
# Requisitos:imagemagick xdialog
# Data: 15/05/2005.

DIALOG="/usr/bin/Xdialog"
TEMP="/tmp/XSSInputBox.TMP"
SS="${HOME}/ScreenShots/"
ID=${1}

if [ ! -d ${SS} ]; then
    mkdir ${SS}
fi

${DIALOG} --title "ScreenShot" --inputbox "Nome:Delay:Qualidade" 0 0 .jpg:0:100 2> ${TEMP}.$$
RET=${?}

# Isso está péssimo, mas a preguiça impede de fazer algo
# agora para elimitar esse monte de 'cat'.

FILENAME=`cat ${TEMP}.$$ | cut -d":" -f1`
DELAY=`cat ${TEMP}.$$ | cut -d":" -f2`
QUALITY=`cat ${TEMP}.$$ | cut -d":" -f3`

# Ano Mês Dia Hora Minuto Segundo
AGORA=`date "+%G%m%d%H%M%S"`
FILENAME=${FILENAME:="Screen-${AGORA}.jpg"}
DELAY=${DELAY:="0"}
QUALITY=${QUALITY:="100"}

rm -f ${TEMP}.$$

case ${RET} in
    0)
        if [ ${ID} ]; then
            import -pause ${DELAY} -quality ${QUALITY} -window ${ID} ${SS}/"${FILENAME}"
        else
            import -pause ${DELAY} -quality ${QUALITY} -window root ${SS}/"${FILENAME}"
        fi
        ;;
    1)
        # Botão Cancel.
        exit
        ;;
    255)
        # Janela Fechada.
        exit
        ;;
esac
