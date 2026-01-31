#!/bin/bash
# Sports Odds CLI - Fetch odds from The Odds API
# Usage: odds.sh <sport_key> [markets] [--json]

set -e

API_KEY_FILE="${HOME}/.config/sports-odds/api_key"
BASE_URL="https://api.the-odds-api.com/v4"

# Load API key
if [[ ! -f "$API_KEY_FILE" ]]; then
    echo "Error: API key not found. Create $API_KEY_FILE with your key."
    echo "Get a free key at https://the-odds-api.com"
    exit 1
fi
API_KEY=$(cat "$API_KEY_FILE" | tr -d '[:space:]')

# List sports mode
if [[ "$1" == "--sports" || "$1" == "-s" ]]; then
    curl -s "${BASE_URL}/sports/?apiKey=${API_KEY}" | jq -r '.[] | select(.active == true) | "\(.key)\t\(.title)"' | column -t -s $'\t'
    exit 0
fi

# Parse arguments
SPORT="${1:-upcoming}"
MARKETS="${2:-h2h}"
REGIONS="${3:-us}"
FORMAT="american"

# Fetch odds
RESPONSE=$(curl -s "${BASE_URL}/sports/${SPORT}/odds/?apiKey=${API_KEY}&regions=${REGIONS}&markets=${MARKETS}&oddsFormat=${FORMAT}")

# Check for errors
if echo "$RESPONSE" | jq -e '.message' > /dev/null 2>&1; then
    echo "Error: $(echo "$RESPONSE" | jq -r '.message')"
    exit 1
fi

# Calculate implied probability from American odds
calc_implied_prob() {
    local odds=$1
    if [[ $odds -lt 0 ]]; then
        echo "scale=4; ${odds#-} / (${odds#-} + 100)" | bc
    else
        echo "scale=4; 100 / ($odds + 100)" | bc
    fi
}

# Process and output with implied probabilities
echo "$RESPONSE" | jq -r '
    .[] | 
    "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━",
    "🏈 \(.away_team) @ \(.home_team)",
    "⏰ \(.commence_time)",
    "",
    (.bookmakers[] | 
        "📚 \(.title)",
        (.markets[] | 
            "   \(.key): " + 
            ([.outcomes[] | "\(.name): \(.price)"] | join(" | "))
        )
    ),
    ""
'

# Show remaining quota
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
curl -sI "${BASE_URL}/sports/${SPORT}/odds/?apiKey=${API_KEY}&regions=${REGIONS}&markets=${MARKETS}&oddsFormat=${FORMAT}" 2>/dev/null | grep -i "x-requests-remaining" || true
