#!/bin/bash
# Gentil de Bortoli Júnior <gentiljunior@bortoli.com.br>
# Script para executar o processo de travamento automático do X.
# OBS.: Feito para ser utilizado em conjunto com o FVWM.
# Requisitos:xtrlock xautolock
# Data: 15/05/2005.

HEIGHT=`xwininfo -root | grep Height | cut -d : -f2 | tr -d " "`

case ${HEIGHT} in
    768   ) OFFSET=760  ;;
    1024  ) OFFSET=1015 ;;
    *     ) OFFSET=760  ;;
esac

XAUTOLOCK="/usr/bin/X11/xautolock"

# Tempo de inatividade para disparar LOCKER, em minutos.
TEMPO_TRAVA=1
# Tempo, em segundos, para dar o aviso de que LOCKER será executado.
TEMPO_AVISA=10

# Programa que será disparado ao atingir TEMPO_TRAVA.
# Pode ser qualquer programa.
LOCKER="/usr/bin/X11/xtrlock"

# Comando que será utilizado para avisar TEMPO_AVISA segundos
# antes que LOCKER ser disparado.
NOTIFIER="${HOME}/.fvwm/Scripts/Notifier.sh"

# Mensagem a ser exibida.
MSG="Travando em ${TEMPO_AVISA} Segundos..."

${XAUTOLOCK} -time ${TEMPO_TRAVA} -locker ${LOCKER} -notify \
${TEMPO_AVISA} -notifier "${NOTIFIER} '${MSG}' ${OFFSET}" &
