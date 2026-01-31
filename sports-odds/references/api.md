# The Odds API Reference

## Endpoints

### GET /v4/sports
List available sports (in-season). Free, doesn't count against quota.

### GET /v4/sports/{sport}/odds
Get odds for upcoming/live games.

**Parameters:**
- `sport` — Sport key (e.g., `americanfootball_nfl`)
- `apiKey` — Your API key
- `regions` — Bookmaker regions: `us`, `us2`, `uk`, `au`, `eu`
- `markets` — Comma-separated: `h2h`, `spreads`, `totals`, `outrights`
- `oddsFormat` — `american` or `decimal`
- `dateFormat` — `iso` or `unix`

**Quota Cost:** 1 credit per region per market

### GET /v4/sports/{sport}/scores
Get scores for live/recent games (up to 3 days back).

## Sport Keys

### US Sports
| Sport | Key |
|-------|-----|
| NFL | `americanfootball_nfl` |
| College Football (NCAAF) | `americanfootball_ncaaf` |
| NBA | `basketball_nba` |
| College Basketball (NCAAB) | `basketball_ncaab` |
| WNBA | `basketball_wnba` |
| NHL | `icehockey_nhl` |
| MLB | `baseball_mlb` |
| MLS | `soccer_usa_mls` |

### Combat Sports
| Sport | Key |
|-------|-----|
| UFC/MMA | `mma_mixed_martial_arts` |
| Boxing | `boxing_boxing` |

### Soccer
| League | Key |
|--------|-----|
| EPL | `soccer_epl` |
| La Liga | `soccer_spain_la_liga` |
| Bundesliga | `soccer_germany_bundesliga` |
| Serie A | `soccer_italy_serie_a` |
| Ligue 1 | `soccer_france_ligue_one` |
| Champions League | `soccer_uefa_champs_league` |

### Golf
| Tournament | Key |
|------------|-----|
| Masters | `golf_masters_tournament_winner` |
| PGA Championship | `golf_pga_championship_winner` |
| US Open | `golf_us_open_winner` |
| The Open | `golf_the_open_championship_winner` |

## Response Schema

```json
{
  "id": "game_id",
  "sport_key": "americanfootball_nfl",
  "commence_time": "2026-02-08T23:30:00Z",
  "home_team": "New England Patriots",
  "away_team": "Seattle Seahawks",
  "bookmakers": [
    {
      "key": "fanduel",
      "title": "FanDuel",
      "last_update": "2026-01-31T04:00:00Z",
      "markets": [
        {
          "key": "h2h",
          "outcomes": [
            {"name": "Seattle Seahawks", "price": -188},
            {"name": "New England Patriots", "price": 158}
          ]
        }
      ]
    }
  ]
}
```

## Odds Conversion

### American to Implied Probability
```
Negative: prob = |odds| / (|odds| + 100)
Positive: prob = 100 / (odds + 100)

Example: -150 → 150/250 = 60%
Example: +200 → 100/300 = 33.3%
```

### American to Decimal
```
Negative: decimal = 1 + (100 / |odds|)
Positive: decimal = 1 + (odds / 100)

Example: -150 → 1.67
Example: +200 → 3.00
```

## Quota Management

Free tier: 500 credits/month

Response headers show usage:
- `x-requests-remaining` — Credits left
- `x-requests-used` — Credits used
- `x-requests-last` — Cost of last call

**Tips:**
- Request multiple markets in one call (cheaper than separate calls)
- Cache results for a few minutes (odds don't change that fast)
- Use `upcoming` sport key for next 8 games across all sports
