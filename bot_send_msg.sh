#!/bin/bash

# Cargar variables desde archivo .env
ENV_FILE=".telegram.env"
if [ -f "$ENV_FILE" ]; then
    export $(grep -v '^#' "$ENV_FILE" | xargs)
else
    echo "No se encontró el archivo de configuración $ENV_FILE"
    exit 1
fi

# Validar entrada
if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Uso: $0 <chat_id> <mensaje>"
    exit 1
fi

CHAT_ID="$1"
MENSAJE="$2"
URL="https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendMessage"

# Enviar mensaje con formato HTML
RESP=$(curl -s -X POST "$URL" \
    -d chat_id="$CHAT_ID" \
    -d text="$MENSAJE" \
    -d parse_mode=html)

# Validar respuesta
OK=$(echo "$RESP" | jq -r '.ok')
if [ "$OK" != "true" ]; then
    echo "❌ Error al enviar mensaje. Respuesta:"
    echo "$RESP"
else
    echo "✅ Mensaje enviado correctamente."
fi
