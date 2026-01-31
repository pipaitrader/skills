#!/bin/bash
# Scan Polymarket for sports markets and compare to sportsbook odds
# Usage: scan-sports.sh [search_term]

set -e

SEARCH="${1:-NFL}"
SPORTS_ODDS_SCRIPT="/data/workspace/skills/sports-odds/scripts/odds-json.sh"

echo "🔍 Scanning Polymarket for: $SEARCH"
echo ""

# Search Polymarket via bankr (uses their search)
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📊 POLYMARKET MARKETS"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

cd /moltbot/skills/bankr
./scripts/bankr.sh "Search Polymarket for $SEARCH sports markets"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📚 SPORTSBOOK ODDS"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Map search term to sport key
case "$SEARCH" in
    *NFL*|*nfl*|*football*)
        SPORT="americanfootball_nfl"
        ;;
    *NBA*|*nba*|*basketball*)
        SPORT="basketball_nba"
        ;;
    *NHL*|*nhl*|*hockey*)
        SPORT="icehockey_nhl"
        ;;
    *MLB*|*mlb*|*baseball*)
        SPORT="baseball_mlb"
        ;;
    *UFC*|*ufc*|*MMA*|*mma*)
        SPORT="mma_mixed_martial_arts"
        ;;
    *)
        SPORT="upcoming"
        ;;
esac

if [[ -f "$SPORTS_ODDS_SCRIPT" ]]; then
    "$SPORTS_ODDS_SCRIPT" "$SPORT" h2h 2>/dev/null | jq '.[0:5]' || echo "Configure sports-odds API key first"
else
    echo "Install sports-odds skill for sportsbook comparison"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "💡 ANALYSIS"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Compare Polymarket prices to sportsbook implied probabilities."
echo "If difference > 5%, investigate why before betting."
