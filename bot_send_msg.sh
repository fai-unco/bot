#!/bin/bash
#Recibe chat-id y mensaje

TOKEN="1253518189:AAEgHcRAvrsOR6RTRamny2TSOV-Fi55aJFI"
#LUYO
#ID="355381139"

#GRUPO STIC-FI
#ID="-357496807"

ID=$1
MENSAJE="<pre>$2</pre>"
MENSAJE="$2"
URL="https://api.telegram.org/bot$TOKEN/sendMessage"
#curl -s -X POST $URL -d chat_id=$ID -d text="$MENSAJE"
curl -s -X POST $URL -d chat_id=$ID -d text="$MENSAJE" -d parse_mode=html
