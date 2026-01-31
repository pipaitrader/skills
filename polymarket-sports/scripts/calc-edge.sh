#!/bin/bash
# Calculate edge between Polymarket price and sportsbook odds
# Usage: calc-edge.sh <polymarket_price> <american_odds>
#
# Example: calc-edge.sh 0.45 -150
# (Polymarket at 45%, sportsbook at -150)

set -e

POLY_PRICE="${1:-0.50}"
AMERICAN_ODDS="${2:-100}"

# Use awk for calculations (more portable than bc)
RESULT=$(awk -v poly="$POLY_PRICE" -v odds="$AMERICAN_ODDS" 'BEGIN {
    # Convert American odds to implied probability
    if (odds < 0) {
        book_prob = (-odds) / ((-odds) + 100)
    } else {
        book_prob = 100 / (odds + 100)
    }
    
    # Calculate edge
    edge = book_prob - poly
    edge_pct = edge * 100
    
    # Calculate payout and EV
    payout = (1 - poly) / poly
    ev = (book_prob * payout * 100) - ((1 - book_prob) * 100)
    
    # Output
    printf "POLY_PCT=%.1f\n", poly * 100
    printf "BOOK_PROB=%.4f\n", book_prob
    printf "BOOK_PCT=%.1f\n", book_prob * 100
    printf "EDGE=%.4f\n", edge
    printf "EDGE_PCT=%.2f\n", edge_pct
    printf "EV=%.2f\n", ev
}')

eval "$RESULT"

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📊 EDGE CALCULATION"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Polymarket Price:     ${POLY_PCT}%"
echo "Sportsbook Odds:      $AMERICAN_ODDS"
echo "Sportsbook Implied:   ${BOOK_PCT}%"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

if awk "BEGIN {exit !($EDGE > 0.05)}"; then
    echo "✅ EDGE FOUND: +${EDGE_PCT}%"
    echo "   Sportsbook thinks YES is more likely than Polymarket"
    echo "   Expected Value per \$100: \$${EV}"
    echo "   Consider: BUY YES on Polymarket"
elif awk "BEGIN {exit !($EDGE < -0.05)}"; then
    EDGE_PCT_ABS=${EDGE_PCT#-}
    echo "✅ EDGE FOUND: ${EDGE_PCT}%"
    echo "   Sportsbook thinks NO is more likely than Polymarket"
    echo "   Consider: BUY NO on Polymarket"
else
    echo "⚪ NO SIGNIFICANT EDGE"
    echo "   Markets are aligned (within 5%)"
fi
echo ""
