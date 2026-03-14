# 📡 Teams Monitor

**Bridge Microsoft Teams messages into GitHub Issues** — so your AI agents never miss an actionable request.

## What It Does

- Monitors Teams channels for messages directed at your team
- Filters signal from noise (ignores bot messages, reactions, etc.)
- Creates GitHub issues from actionable messages
- Runs on a schedule or on-demand

## How It Works

Uses WorkIQ (`workiq-ask_work_iq`) to read Teams messages, applies relevance filtering, and creates structured GitHub issues when action is needed.

## Requirements

- WorkIQ MCP server (for reading Teams)
- GitHub CLI (`gh`) for issue creation
- Teams Incoming Webhook (for sending responses back)

## Files

- **SKILL.md** — Full agent-consumable knowledge with monitoring patterns and filtering rules

## Quick Example

Tell your AI agent:
> "Check Teams for any messages that need attention"

The skill teaches the agent to query WorkIQ, filter for relevant messages, and create properly labeled GitHub issues.
