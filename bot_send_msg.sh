#!/bin/bash

# Load environment variables
ENV_FILE=".telegram.env"
if [ -f "$ENV_FILE" ]; then
    export $(grep -v '^#' "$ENV_FILE" | xargs)
else
    echo "Configuration file $ENV_FILE not found."
    exit 1
fi

# Validate environment variables
if [ -z "$TELEGRAM_BOT_TOKEN" ] || [ -z "$TELEGRAM_CHAT_ID" ]; then
    echo "Missing TELEGRAM_BOT_TOKEN or TELEGRAM_CHAT_ID in $ENV_FILE"
    exit 1
fi

# Validate message argument
if [ -z "$1" ]; then
    echo "Usage: $0 <message>"
    exit 1
fi

MESSAGE="$1"
URL="https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendMessage"

# Send message with HTML formatting
RESPONSE=$(curl -s -X POST "$URL" \
    -d chat_id="$TELEGRAM_CHAT_ID" \
    -d text="$MESSAGE" \
    -d parse_mode=html)

# Check Telegram API response
OK=$(echo "$RESPONSE" | jq -r '.ok')
if [ "$OK" != "true" ]; then
    echo "❌ Failed to send message. Response:"
    echo "$RESPONSE"
else
    echo "✅ Message sent successfully."
fi
