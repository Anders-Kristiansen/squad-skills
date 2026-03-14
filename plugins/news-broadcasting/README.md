# 📰 News Broadcasting Skill

Codifies formats and delivery mechanisms for tech news reporting to team channels. Any AI agent can reference this skill to produce consistent, engaging news broadcasts.

## What It Does

This skill teaches your AI agent to:

- **Scan for tech news** — Identify relevant industry updates, release announcements, and technical developments
- **Compile summaries** — Aggregate multiple news items into a cohesive briefing
- **Format for teams** — Create styled messages with sections, categories, and visual indicators
- **Deliver reliably** — Send to team channels via webhooks or messaging APIs
- **Add personality** — Apply humor guidelines while staying professional

## Trigger Phrases

Use these to invoke the skill:
- `news`
- `tech news`
- `daily briefing`
- `news report`
- `scan news`

## Quick Start

### Prerequisites

- Access to a team messaging platform (Slack, Microsoft Teams, Discord, etc.)
- Webhook URL for posting messages (store securely in your configuration)
- AI agent with access to web browsing or news APIs

### Example Usage

```
User: "Compile a daily tech news briefing for the team"
Agent: [Uses news-broadcasting skill to scan tech news sources]
Agent: "📰 **DAILY BRIEFING** — Here are today's key stories..."
```

## Capabilities

### News Formats

- **Daily Briefing** — Full summary with issues closed, PRs merged, decisions made, blockers
- **Breaking News** — Immediate alerts for critical events with short, punchy copy
- **Weekly Recap** — End-of-week summary with stats, highlights, and top stories
- **Status Flash** — Quick snapshot of what's in progress, blocked, or needs attention

### Delivery Methods

- **Webhook-based delivery** to team channels
- **Adaptive Cards** for rich formatting
- **Markdown messages** with styled sections and emoji categories
- **API integration** with messaging platforms

### Message Styling

- 📰 News header banners
- Section dividers (━━━)
- Emoji categories (🟢 Done, 🟡 In Progress, 🔴 Blocked)
- Pull quotes for key decisions
- Stats counters for metrics

## Humor & Tone Guidelines

Apply these principles when crafting news broadcasts:

- **Tech Puns** — "Dev-lightful fixes", "merge-ty news", wordplay tied to tech concepts
- **Playful Analogies** — Compare team work to relatable scenarios
- **Self-Deprecating Humor** — Observations about being an AI news bot
- **Witty Observations** — Sharp, quick takes on the news
- **Tone** — Funny but professional. Make people smile, not cringe

## Integration Examples

### With Webhook Messaging

```powershell
$webhookUrl = "YOUR_WEBHOOK_URL_HERE"
$body = @{ 
    text = "📰 **BREAKING:** Your news here" 
} | ConvertTo-Json

Invoke-RestMethod -Uri $webhookUrl -Method Post -ContentType "application/json" -Body $body
```

### With Modern Messaging APIs

Use your platform's native Adaptive Card or message formatting.

## See Also

- [GitHub Project Board](../github-project-board/) — Track team workflow
- [Teams Monitor](../teams-monitor/) — Monitor channels for events
- [Cross Machine Coordination](../cross-machine-coordination/) — Distribute work across agents

