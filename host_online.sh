#!/bin/bash

HOST_IP=$1
PARA="355381139" #luyo

#fping -c1 -t300 $IP 2>/dev/null 1>/dev/null
ping -c 3 $HOST_IP 2>/dev/null 1>/dev/null

if [ "$?" = 0 ]
then
    #echo "Host found"
    #/root/bot/bot_send_msg.sh $PARA "$HOST_IP esta online"
    echo "."
else
    #echo "Host not found"
    /root/bot/bot_send_msg.sh $PARA "$HOST_IP parece que esta offline"
fi

