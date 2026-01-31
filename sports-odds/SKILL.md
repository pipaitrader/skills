---
name: sports-odds
description: Get real-time sports betting odds from major sportsbooks via The Odds API. Use when comparing betting lines, calculating implied probabilities, finding value bets, or getting odds for specific games across NFL, NBA, NHL, MLB, soccer, and more. Covers DraftKings, FanDuel, BetMGM, Caesars, Pinnacle, and 40+ bookmakers worldwide.
---

# Sports Odds

Fetch and compare real-time sports betting odds from multiple sportsbooks.

## Quick Start

```bash
# Get NFL odds (moneyline)
scripts/odds.sh americanfootball_nfl

# Get NBA spreads
scripts/odds.sh basketball_nba spreads

# Get specific markets
scripts/odds.sh americanfootball_nfl h2h,spreads,totals

# List all available sports
scripts/odds.sh --sports
```

## Setup

1. Get free API key at https://the-odds-api.com (500 credits/month free)
2. Store key:
```bash
mkdir -p ~/.config/sports-odds
echo "YOUR_API_KEY" > ~/.config/sports-odds/api_key
```

## Sport Keys

| Sport | Key |
|-------|-----|
| NFL | `americanfootball_nfl` |
| College Football | `americanfootball_ncaaf` |
| NBA | `basketball_nba` |
| College Basketball | `basketball_ncaab` |
| NHL | `icehockey_nhl` |
| MLB | `baseball_mlb` |
| Soccer (EPL) | `soccer_epl` |
| UFC/MMA | `mma_mixed_martial_arts` |

Run `scripts/odds.sh --sports` for full list.

## Markets

- `h2h` — Moneyline (who wins)
- `spreads` — Point spread / handicap
- `totals` — Over/under points
- `outrights` — Futures (championship winner)

## Output

Returns JSON with:
- Game info (teams, start time)
- Odds from each bookmaker
- Implied probabilities (calculated)

## Comparing to Polymarket

Convert American odds to implied probability:
- Negative odds: `prob = |odds| / (|odds| + 100)`
- Positive odds: `prob = 100 / (odds + 100)`

If Polymarket price differs significantly from sportsbook consensus, there may be value.

## References

- [API Details](references/api.md) — Full API documentation
- [Bookmakers](references/bookmakers.md) — List of covered sportsbooks
