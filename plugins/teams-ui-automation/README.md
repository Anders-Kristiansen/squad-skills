# 🖥️ Teams UI Automation

**Hybrid Microsoft Teams automation** using three complementary layers — because sometimes the Graph API isn't enough.

## What It Does

Automates Teams operations that aren't available through Microsoft Graph API:
- Installing apps into channels
- Managing tabs and connectors
- UI navigation and interaction
- Window management and focus control

## How It Works

| Layer | Technology | Use Case |
|-------|-----------|----------|
| 🥇 Primary | Playwright MCP | DOM access inside Teams WebView |
| 🥈 Secondary | PowerShell keyboard shortcuts | Quick navigation, channel switching |
| 🥉 Tertiary | UI Automation (UIA) | Window management, focus control |

## Requirements

- Microsoft Teams desktop app (new version, ms-teams.exe)
- Playwright MCP server configured
- PowerShell 5.1+
- Windows OS

## Files

- **SKILL.md** — Full agent-consumable knowledge (triggers, recipes, patterns)
- **scripts/Teams-UIA.ps1** — PowerShell module for keyboard shortcuts and window management

## Quick Example

Tell your AI agent:
> "Install the GitHub app into the #general channel in Teams"

The skill teaches the agent to use Playwright to navigate the Teams UI, find the app catalog, and complete the installation flow.
