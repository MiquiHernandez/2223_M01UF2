#!/bin/bash

PORT="2223"

echo "Servidor Transfer Unite Recursive International Protocol: TURIP"
echo "(0)LISTEN "

MSG=`nc -l $PORT`

HANDSHAKE=`echo $MSG | cut -d " " -f 1`
IP_CLIENT=`echo $MSG | cut -d " " -f 2`

if [ "$HANDSHAKE" != "HOLI_TURIP" ] 
then
 echo " ERROR 1:Handshake incorrecto "

 echo " KO_TURIP "| nc $IP_CLIENT $PORT

exit 1 

fi 

 echo "OK_TURIP"| nc $IP_CLIENT $PORT

echo"(4) LISTEN"

MSG=`nc -l $PORT`

echo "(7)SEND: Comprobación de nombre archivo"

PREFIX=`echo $MSG| cut -d " " -f 1`
FILE_NAME=`echo $MSG| cut -d " " -f 2`

if [ "$PREFIX" != "FILE_NAME" ]
then
echo " ERROR 2:Incorrect Prefix"

echo "KO_FILE_NAME" |nc $IP_CLIENT $PORT

exit 2
fi

echo "OK_FILE_NAME"| nc $IP_CLIENT $PORT

echo "(8) LISTEN"

`nc -l $PORT`> inbox/$FILE_NAME




exit 0
