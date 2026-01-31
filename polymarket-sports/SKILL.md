---
name: polymarket-sports
description: Find sports betting value on Polymarket by comparing prediction market odds to sportsbook consensus. Use when looking for Polymarket sports bets, comparing Polymarket odds to sportsbooks, finding arbitrage opportunities, or analyzing sports prediction markets. Identifies markets where Polymarket prices diverge from sharp sportsbook lines.
---

# Polymarket Sports

Find edge in Polymarket sports markets by comparing to sportsbook odds.

## Quick Start

```bash
# Scan for Super Bowl value
scripts/scan-sports.sh "Super Bowl"

# Compare specific market to sportsbook odds
scripts/compare-market.sh "nfl-seattle-new-england"

# Get all active sports markets
scripts/list-markets.sh sports
```

## Strategy

### The Edge

Polymarket and sportsbooks price the same events differently because:
1. **Different participant pools** — Polymarket skews crypto/retail, sportsbooks have sharps
2. **Liquidity differences** — Less liquid = more mispricing
3. **News lag** — Polymarket may react slower to injury/lineup news
4. **Public bias** — Polymarket may overweight popular teams

### Finding Value

1. Get sportsbook consensus odds (via `sports-odds` skill)
2. Convert to implied probability
3. Compare to Polymarket price
4. If difference > 5-10%, investigate why:
   - Is Polymarket wrong? (value bet)
   - Is there news the books don't have? (follow Polymarket)
   - Is it just noise? (skip)

### When Polymarket Has Edge

Polymarket may be MORE accurate when:
- Event has political/crypto angle sportsbooks ignore
- News is breaking on Twitter before bookmakers react
- Market has sophisticated traders (check volume)

### When Sportsbooks Have Edge

Sportsbooks are MORE accurate when:
- Sharp money has moved lines
- Event is purely sports-related
- High liquidity on both sides

## Workflow

```
1. scripts/list-markets.sh sports
   → Get active Polymarket sports markets

2. For each interesting market:
   scripts/compare-market.sh <market-id>
   → Compare to sportsbook odds
   
3. If value found:
   bankr.sh "Bet $X on [outcome] at Polymarket"
```

## Bankr Integration

Use bankr to execute Polymarket bets:
```bash
cd /moltbot/skills/bankr
./scripts/bankr.sh "Search Polymarket for Super Bowl"
./scripts/bankr.sh "Bet $20 on Patriots to cover +4.5"
```

## Key Markets to Monitor

### NFL
- Game winners (moneyline equivalent)
- Spreads (point handicaps)
- Super Bowl winner
- Player props

### NBA
- Game winners
- Series winners (playoffs)
- Championship

### Other
- UFC/MMA fight outcomes
- Soccer major tournaments
- Golf majors

## References

- [Polymarket API](references/polymarket-api.md) — Gamma API for fetching markets
- [Edge Calculation](references/edge-calc.md) — How to calculate expected value
