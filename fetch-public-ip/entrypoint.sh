#!/bin/sh
set -eu

: "${DISCORD_WEBHOOK_URL:?Missing DISCORD_WEBHOOK_URL}"

HOSTNAME_TAG="${HOSTNAME_TAG:-$(hostname)}"
DELAY_SECONDS="${DELAY_SECONDS:-0}"

if [ "$DELAY_SECONDS" -gt 0 ] 2>/dev/null; then
  sleep "$DELAY_SECONDS"
fi

IP="$(curl -fsS --max-time 10 https://ifconfig.me)"
MSG="${HOSTNAME_TAG} restarted. Current public IP: ${IP}"

curl -fsS \
  -H "Content-Type: application/json" \
  -X POST \
  -d "{\"content\":\"${MSG}\"}" \
  "$DISCORD_WEBHOOK_URL"
