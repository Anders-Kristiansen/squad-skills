# GitHub Multi-Account Management

AI-driven setup for multi-account GitHub CLI. No manual steps needed.

## How It Works

1. Add this plugin's `SKILL.md` to your `.squad/skills/github-multi-account/` directory
2. Tell your AI: **"set up my GitHub multi-account aliases"**
3. The AI detects your accounts, asks which is personal/work, and sets everything up automatically

That's it. The AI handles the PowerShell profile, CMD wrappers, PATH, and verification.

## What Gets Set Up

| Alias | Purpose |
|-------|---------|
| `ghp` / `gh-personal` | Always runs in your personal account context |
| `ghw` / `gh-work` | Always runs in your work/EMU account context |

No more `gh auth switch` chaos. Each alias locks its own account before every command.

## Install the Skill

```powershell
# In your repo with .squad/
mkdir -p .squad/skills/github-multi-account
curl -o .squad/skills/github-multi-account/SKILL.md https://raw.githubusercontent.com/tamirdresher/squad-skills/main/plugins/github-multi-account/SKILL.md
```

Then just tell your AI to set it up. It reads the SKILL.md and knows what to do.

## Trigger Phrases
- "set up my GitHub accounts"
- "I have two GitHub accounts"
- "fix my gh auth switching"
- "wrong account" / "auth switch"
