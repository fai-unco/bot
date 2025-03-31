#!/bin/bash

# Load environment variables from .env file
ENV_FILE=".telegram.env"
if [ -f "$ENV_FILE" ]; then
    export $(grep -v '^#' "$ENV_FILE" | xargs)
else
    echo "Configuration file $ENV_FILE not found."
    exit 1
fi

# Validate input arguments
if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: $0 <chat_id> <message>"
    exit 1
fi

CHAT_ID="$1"
MESSAGE="$2"
URL="https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendMessage"

# Send message using HTML formatting
RESPONSE=$(curl -s -X POST "$URL" \
    -d chat_id="$CHAT_ID" \
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
