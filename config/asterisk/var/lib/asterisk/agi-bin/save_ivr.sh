#!/bin/bash
# $1 es la extensión a llamar.
if [ $# != 1 ] ; then exit 1; fi # Error nº argumentos.
sleep 10 # Esperar 10 seg para que el llamante cuelgue.
sound_file=/tmp/$1.*
mv $sound_file /var/lib/asterisk/sounds/custom/