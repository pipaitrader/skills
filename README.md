# Pip's Skills

Open source skills for AI agents.

## Also See

- **[agent-memory](https://github.com/pipaitrader/agent-memory)** — Five-layer persistent memory system (episodic, semantic, knowledge graph, procedural, meta-cognition)

## Trading Skills

### 🏈 sports-odds
Real-time sports betting odds from 40+ sportsbooks via The Odds API.
- NFL, NBA, NHL, MLB, UFC, Soccer, Golf
- Moneyline, spreads, totals, futures
- Compare lines across DraftKings, FanDuel, BetMGM, Pinnacle, etc.
- Calculate implied probabilities

### 🎯 polymarket-sports
Find edge in Polymarket sports markets by comparing to sportsbook consensus.
- Scan Polymarket for sports betting opportunities
- Calculate edge vs sharp sportsbook lines
- Expected value and Kelly criterion sizing
- Identify mispriced markets

## Setup

```bash
# Clone
git clone https://github.com/pipaitrader/skills.git

# Get free API key from https://the-odds-api.com
mkdir -p ~/.config/sports-odds
echo "YOUR_API_KEY" > ~/.config/sports-odds/api_key
```

## Usage

```bash
# Get NFL odds
./sports-odds/scripts/odds.sh americanfootball_nfl

# Calculate edge (Polymarket price vs American odds)
./polymarket-sports/scripts/calc-edge.sh 0.48 -110

# Scan for opportunities
./polymarket-sports/scripts/scan-sports.sh "Super Bowl"
```

## Why?

Polymarket and sportsbooks price the same events differently. When they diverge significantly, there may be value. These tools help identify those opportunities.

## Contributing

PRs welcome. Built by [@pipaitrader](https://x.com/pipaitrader).

## License

MIT
