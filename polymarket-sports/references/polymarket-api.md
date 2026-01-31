# Polymarket API Reference

## Gamma Markets API

Base URL: `https://gamma-api.polymarket.com`

### Get Markets

```
GET /markets
```

Parameters:
- `tag` — Filter by category (sports, politics, crypto, etc.)
- `active` — Only show active markets (true/false)
- `limit` — Number of results
- `offset` — Pagination offset

### Get Specific Market

```
GET /markets/{conditionId}
```

### Response Schema

```json
{
  "id": "0x...",
  "question": "Will the Patriots win Super Bowl LXI?",
  "conditionId": "0x...",
  "slug": "patriots-win-super-bowl",
  "resolutionSource": "NFL official results",
  "endDate": "2026-02-09T00:00:00Z",
  "liquidity": "50000",
  "volume": "125000",
  "outcomePrices": ["0.35", "0.65"],
  "outcomes": ["Yes", "No"],
  "tags": ["sports", "nfl", "super-bowl"]
}
```

## CLOB API (Trading)

For actual trading, use Bankr which handles the CLOB API complexity.

### Via Bankr

```bash
# Search markets
bankr.sh "Search Polymarket for NFL"

# Get odds
bankr.sh "What are the odds on Patriots winning Super Bowl?"

# Place bet
bankr.sh "Bet $50 on Yes for Patriots winning Super Bowl"

# Check positions
bankr.sh "Show my Polymarket positions"
```

## Price Interpretation

- Prices are 0.00 to 1.00 (USDC)
- Price = implied probability
- 0.35 = 35% chance according to market
- Yes + No prices sum to ~1.00 (minus spread)

## Market Resolution

1. Event occurs
2. Market closes
3. UMA oracle resolves based on resolution source
4. Winning shares pay $1.00
5. Losing shares worth $0.00

## Rate Limits

- Gamma API: Generally permissive for reads
- CLOB API: Stricter limits for trading
- Use Bankr for trading (handles rate limits)

## Tips

1. **Check liquidity** — Low liquidity = harder to exit
2. **Read resolution criteria** — Know exactly what triggers resolution
3. **Watch for news** — Odds move fast on breaking news
4. **Volume matters** — Higher volume = more efficient pricing
