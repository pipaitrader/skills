#!/bin/bash
# Compare odds across bookmakers to find best lines
# Usage: compare-lines.sh <sport_key> [market]

set -e

API_KEY_FILE="${HOME}/.config/sports-odds/api_key"
BASE_URL="https://api.the-odds-api.com/v4"

if [[ ! -f "$API_KEY_FILE" ]]; then
    echo "Error: API key not found"
    exit 1
fi
API_KEY=$(cat "$API_KEY_FILE" | tr -d '[:space:]')

SPORT="${1:-upcoming}"
MARKET="${2:-h2h}"

curl -s "${BASE_URL}/sports/${SPORT}/odds/?apiKey=${API_KEY}&regions=us&markets=${MARKET}&oddsFormat=american" | jq -r '
    .[] | 
    "\n🏆 \(.away_team) @ \(.home_team)",
    "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━",
    (
        # Get all outcomes across bookmakers
        [.bookmakers[].markets[].outcomes[]] | 
        group_by(.name) | 
        .[] | 
        {
            name: .[0].name,
            best_odds: ([.[].price] | max),
            worst_odds: ([.[].price] | min),
            books: (. | map({price, book: "unknown"}) | length)
        } |
        "  \(.name):",
        "    Best: \(.best_odds) | Worst: \(.worst_odds) | Spread: \(.best_odds - .worst_odds)"
    )
'
