# Edge Calculation Guide

## The Formula

```
Edge = True Probability - Market Price
```

If edge > 0, you have value betting YES.
If edge < 0, you have value betting NO.

## Using Sportsbooks as "True" Probability

Sharp sportsbooks (Pinnacle, Circa) are generally efficient. Their odds approximate true probability after removing vig.

### Removing the Vig

Sportsbook odds include a margin (vig). To get true probability:

```
Raw implied prob (favorite): |odds| / (|odds| + 100)
Raw implied prob (underdog): 100 / (odds + 100)

Total implied prob = favorite + underdog (usually > 100%)
True prob = raw_prob / total_implied_prob
```

Example:
- Favorite: -150 → 60%
- Underdog: +130 → 43.5%
- Total: 103.5%
- True prob (favorite): 60% / 103.5% = 58%
- True prob (underdog): 43.5% / 103.5% = 42%

## Expected Value (EV)

```
EV = (win_prob × profit_if_win) - (lose_prob × loss_if_lose)
```

For Polymarket:
- Buying YES at $0.40:
  - If win: profit = $0.60 per share
  - If lose: loss = $0.40 per share

```
EV = (true_prob × 0.60) - ((1 - true_prob) × 0.40)
```

## Kelly Criterion

Optimal bet size based on edge:

```
Kelly % = (bp - q) / b

Where:
b = decimal odds - 1 (profit per $1)
p = probability of winning
q = probability of losing (1 - p)
```

**Use fractional Kelly (25-50%)** to reduce variance.

## Example Analysis

**Market:** Patriots +4.5 vs Seahawks

| Source | Implied Prob |
|--------|--------------|
| Polymarket | 48% |
| DraftKings | 52% |
| FanDuel | 51% |
| Pinnacle | 53% |

**Analysis:**
- Sportsbook consensus: ~52%
- Polymarket: 48%
- Edge: +4%

**Verdict:** Potential value on YES (Patriots +4.5) at Polymarket.

## When to Bet

| Edge | Action |
|------|--------|
| < 3% | Skip (noise) |
| 3-5% | Small bet if confident |
| 5-10% | Standard bet |
| > 10% | Large edge OR something's wrong |

## Red Flags

- **Edge > 15%:** Usually means you're missing information
- **Low volume market:** Harder to exit, prices less reliable
- **Breaking news:** Wait for markets to settle
- **Resolution ambiguity:** Read criteria carefully

## Tracking Performance

Keep a log:
```
Date | Market | Polymarket Price | Book Odds | Edge | Bet Size | Result
```

Over time, if your bets are +EV, you should profit. Track to verify.
