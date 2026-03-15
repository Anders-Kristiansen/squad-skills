# GitHub Multi-Account Management

Stop the account-switching chaos. If you have multiple GitHub accounts (personal + work/EMU), this skill teaches AI agents to use account-locked aliases instead of fragile `gh auth switch` commands.

## The Problem

AI agents constantly fail multi-account workflows:
- Forget to switch accounts before operations
- Switch to wrong account
- Switch back too early, breaking subsequent commands
- Create PRs/issues on wrong repos

## The Solution

Account-locked aliases that auto-switch context before every command:

```powershell
# Define once (add to PowerShell profile)
function gh-personal { gh auth switch --user YOUR_PERSONAL_ACCOUNT 2>$null | Out-Null; gh @args }
function gh-work { gh auth switch --user YOUR_WORK_ACCOUNT 2>$null | Out-Null; gh @args }
Set-Alias ghp gh-personal
Set-Alias ghw gh-work
```

Then NEVER use bare `gh` for repo operations again:

```powershell
ghp repo list                    # always personal context
ghw issue list                   # always work context
ghp pr create --title "fix"      # personal, guaranteed
ghw pr merge 42                  # work, guaranteed
```

## One-Line Setup

```powershell
# Replace with YOUR GitHub usernames:
irm https://raw.githubusercontent.com/tamirdresher/squad-skills/main/plugins/github-multi-account/setup.ps1 -OutFile setup.ps1; pwsh setup.ps1 -Personal YOUR_PERSONAL -Work YOUR_WORK; rm setup.ps1
```

Or if you already cloned the repo:
```powershell
pwsh plugins/github-multi-account/setup.ps1 -Personal myuser -Work myuser_microsoft
```

This automatically:
- Adds `ghp`/`ghw` functions to your PowerShell profile
- Creates CMD wrappers in `~/.squad/bin/` (added to PATH)
- Installs the SKILL.md to your repo's `.squad/skills/`
- Loads everything in the current session

## Manual Setup (if you prefer)

1. Add the functions to your PowerShell profile (`$PROFILE.CurrentUserAllHosts`)
2. Replace `YOUR_PERSONAL_ACCOUNT` and `YOUR_WORK_ACCOUNT` with your actual GitHub usernames
3. For CMD/batch: create `gh-personal.cmd` and `gh-work.cmd` wrapper scripts
4. Add `SKILL.md` to your agent's skill directory

## For AI Agents

Add `SKILL.md` to your `.squad/skills/github-multi-account/` directory. Every agent that touches GitHub will read this skill and use the correct alias automatically.

## Trigger Phrases

- "wrong account", "auth switch", "EMU account"
- "push to personal repo", "create issue on work repo"
- Any GitHub operation targeting a specific account's repos

