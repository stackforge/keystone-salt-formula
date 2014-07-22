#!/bin/bash

TIMEOUT=$1
HOST=$2
PORT=$3

COUNT=0

while ! nc -w 1 $HOST $PORT</dev/null; 
do 
    sleep 1; 
    COUNT=$(( $COUNT+1 ))
    if [ $COUNT -gt $TIMEOUT ]; then
        echo 
        printf "result=False comment=\"$HOST:$PORT is not avaliable\"\n"
        exit 1
    fi
done
echo
printf "result=True comment=\"$HOST:$PORT is avaliable\"\n"
true
