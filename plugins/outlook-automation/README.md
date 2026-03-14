# Outlook Automation

Control Microsoft Outlook on Windows via COM automation. Create meetings, send emails, search your inbox, manage calendar events, and more — all from your AI agent.

## Requirements

- **Windows** with **Microsoft Outlook** installed and configured with an account
- PowerShell (available by default on Windows)

## Capabilities

| Feature | Description |
|---------|-------------|
| **Send Email** | Compose and send emails with attachments, CC/BCC |
| **Read Inbox** | List recent emails, filter by date/sender/subject |
| **Search Email** | DASL/Jet query filters across folders |
| **Reply/Forward** | Reply, Reply All, Forward existing emails |
| **Create Appointment** | Schedule appointments (no attendees) |
| **Create Meeting** | Schedule meetings with required/optional attendees |
| **Recurring Events** | Daily, weekly, monthly recurrence patterns |
| **List Calendar** | View upcoming events with date range filters |
| **Modify/Cancel** | Update or delete existing meetings |
| **Contacts** | Create and search Outlook contacts |
| **Tasks** | Create Outlook tasks with priority and due dates |
| **Folder Management** | List folders, move emails between folders |

## Quick Start

Add `SKILL.md` to your agent's skill/knowledge directory. The skill teaches your agent how to use Outlook's COM interface via PowerShell.

### For GitHub Copilot (CLI)
Copy `SKILL.md` to `.squad/skills/outlook-automation/SKILL.md` in your repo.

### For Claude
Add the contents of `SKILL.md` to your project knowledge or system prompt.

### For Any Agent
Include `SKILL.md` content as reference documentation for Outlook automation tasks.

## Trigger Phrases

The agent activates on phrases like:
- "create meeting", "schedule a meeting"
- "send email", "compose email"  
- "search emails", "find emails about..."
- "check inbox", "read inbox"
- "calendar", "schedule", "appointment"
- "outlook"

## Platform Limitation

This skill is **Windows-only** — it uses Outlook's COM automation interface. For cross-platform email/calendar access, consider Microsoft Graph API instead.
