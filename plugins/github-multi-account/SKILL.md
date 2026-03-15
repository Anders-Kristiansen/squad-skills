---
name: github-multi-account
description: Use account-locked gh aliases (gh-personal/ghp, gh-work/ghw) for multi-account GitHub operations. NEVER use bare gh + gh auth switch.
confidence: high
---

# GitHub Multi-Account — MANDATORY PATTERN

## Problem
Multiple GitHub accounts (personal + work/EMU) cause constant failures when agents use bare `gh` commands with manual `gh auth switch`.

## Solution — Account-Locked Aliases

Define these in every session or PowerShell profile:

```powershell
function gh-personal { gh auth switch --user YOUR_PERSONAL 2>$null | Out-Null; gh @args }
function gh-work { gh auth switch --user YOUR_WORK 2>$null | Out-Null; gh @args }
```

## Rules

1. **NEVER** use bare `gh` for repo operations — always use `gh-personal` or `gh-work`
2. **NEVER** manually run `gh auth switch` — the aliases handle it
3. Determine which alias by the repo owner:
   - Personal account repos → `gh-personal` / `ghp`
   - Work/EMU account repos → `gh-work` / `ghw`
4. For account-agnostic operations (`gh auth status`), bare `gh` is OK

## Examples

```powershell
# Work/EMU operations
gh-work issue list
gh-work pr create --title "fix bug" --body "..."
gh-work repo view my-org/my-repo

# Personal operations
gh-personal repo list
gh-personal issue create --repo myuser/my-project --title "new feature"

# Cross-account in one script — SAFE
gh-work issue list --json number,title    # work context
gh-personal repo list --json name         # personal context — no conflict!
```

## Setup for Agents

At the TOP of any script that uses GitHub CLI, define the functions:

```powershell
function gh-personal { gh auth switch --user YOUR_PERSONAL 2>$null | Out-Null; gh @args }
function gh-work { gh auth switch --user YOUR_WORK 2>$null | Out-Null; gh @args }
```

Replace YOUR_PERSONAL and YOUR_WORK with actual GitHub usernames.
