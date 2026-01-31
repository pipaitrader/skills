#!/bin/bash
# List Polymarket sports markets via Gamma API
# Usage: list-markets.sh [category] [--active]

set -e

GAMMA_URL="https://gamma-api.polymarket.com"

CATEGORY="${1:-sports}"
LIMIT="${2:-50}"

# Fetch markets
# Note: Gamma API structure may vary - adjust as needed
curl -s "${GAMMA_URL}/markets?tag=${CATEGORY}&limit=${LIMIT}&active=true" | jq -r '
    .[] |
    "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━",
    "📊 \(.question // .title)",
    "🆔 \(.id // .conditionId)",
    "💰 Volume: $\(.volume // "N/A")",
    "📈 Yes: \((.outcomePrices[0] // .yes_price // "N/A") | tonumber * 100 | round)%",
    "📉 No: \((.outcomePrices[1] // .no_price // "N/A") | tonumber * 100 | round)%",
    "🔗 https://polymarket.com/event/\(.slug // .id)",
    ""
' 2>/dev/null || echo "Note: Adjust API endpoint based on current Gamma API structure"
