#!/bin/bash
# Sports Odds CLI - Raw JSON output with calculated probabilities
# Usage: odds-json.sh <sport_key> [markets]

set -e

API_KEY_FILE="${HOME}/.config/sports-odds/api_key"
BASE_URL="https://api.the-odds-api.com/v4"

if [[ ! -f "$API_KEY_FILE" ]]; then
    echo '{"error": "API key not found. Create ~/.config/sports-odds/api_key"}'
    exit 1
fi
API_KEY=$(cat "$API_KEY_FILE" | tr -d '[:space:]')

SPORT="${1:-upcoming}"
MARKETS="${2:-h2h}"
REGIONS="${3:-us}"

curl -s "${BASE_URL}/sports/${SPORT}/odds/?apiKey=${API_KEY}&regions=${REGIONS}&markets=${MARKETS}&oddsFormat=american" | jq '
    [.[] | {
        id: .id,
        sport: .sport_key,
        commence_time: .commence_time,
        home_team: .home_team,
        away_team: .away_team,
        bookmakers: [.bookmakers[] | {
            key: .key,
            title: .title,
            markets: [.markets[] | {
                key: .key,
                outcomes: [.outcomes[] | {
                    name: .name,
                    price: .price,
                    implied_prob: (
                        if .price < 0 then
                            ((.price | fabs) / ((.price | fabs) + 100))
                        else
                            (100 / (.price + 100))
                        end
                    ) | . * 100 | round / 100
                }]
            }]
        }]
    }]
'
