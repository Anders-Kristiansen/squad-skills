# GitHub Multi-Account Proxy

Transparent `gh` CLI proxy that auto-routes commands to the correct GitHub account based on your repo's git remote URL. No more remembering aliases or switching accounts.

## How It Works

A PowerShell function named `gh` intercepts every call, reads your repo's `origin` remote URL, matches it against a routing table, sets `GH_CONFIG_DIR` to the correct isolated config directory, and delegates to the real `gh.exe`.

If you (or Ralph, or `ghe`/`ghp`) already set `GH_CONFIG_DIR`, the proxy respects that and doesn't override.

## What Gets Set Up

| Component | Purpose |
|-----------|---------|
| `gh` function | Transparent proxy — auto-routes based on remote URL |
| `Test-GhTokenHealth` | Checks if tokens are valid for both accounts |
| `Repair-GhToken` | Re-authenticates an expired profile (opens browser) |
| Git credential helper | `git push/pull` also respects GH_CONFIG_DIR |

### Backward Compatible

The old `ghe`/`ghp`/`ghw` aliases continue to work. They set `GH_CONFIG_DIR` explicitly, and the proxy respects any explicit setting.

## Install

### Option A: Setup Script (recommended)

```powershell
# Clone or download the plugin, then:
.\setup.ps1
```

This will:
1. Add the `gh` proxy function to your `$PROFILE`
2. Add `Test-GhTokenHealth` and `Repair-GhToken` to your `$PROFILE`
3. Configure `git credential.helper` to use `gh auth git-credential`
4. Verify both profiles are healthy

### Option B: Manual

```powershell
# Add to your $PROFILE:
. "path\to\gh-proxy.ps1"
git config --global credential.helper '!gh auth git-credential'
```

### Option C: Install SKILL.md for AI Agents

```powershell
mkdir -p .squad/skills/github-multi-account
curl -o .squad/skills/github-multi-account/SKILL.md https://raw.githubusercontent.com/tamirdresher/squad-skills/main/plugins/github-multi-account/SKILL.md
```

Your AI agent reads the SKILL.md and understands the proxy architecture.

## Prerequisites

- GitHub CLI (`gh`) installed
- Two isolated GH config directories already created:
  - `~/.config/gh-emu/` (work/EMU account)
  - `~/.config/gh-public/` (personal account)
- Run `setup-gh-isolated-auth.ps1` if you haven't set up the isolated dirs yet

## Verify

```powershell
# Check token health
Test-GhTokenHealth

# Test routing (in a personal repo)
cd ~/repos/my-personal-repo
gh api user --jq '.login'    # → tamirdresher

# Test routing (in a work repo)
cd ~/repos/my-emu-repo
gh api user --jq '.login'    # → tamirdresher_microsoft
```

## Customization

Edit the routing table in `gh-proxy.ps1`:

```powershell
$script:GH_ROUTING_TABLE = @(
    @{ Pattern = 'your-emu-org';     ConfigDir = "$HOME\.config\gh-emu";    Label = 'EMU' }
    @{ Pattern = 'your-personal/';   ConfigDir = "$HOME\.config\gh-public"; Label = 'Personal' }
)
```

## Trigger Phrases (for AI agents)

- "set up my GitHub accounts"
- "wrong GitHub account"
- "gh auth switching"
- "fix my gh proxy"
- "token expired"
- "check token health"

## Architecture

Based on [Picard's Decision: GH Auth Proxy — Transparent Multi-Identity Routing](../../.squad/decisions/inbox/picard-gh-auth-proxy.md). Selected Option E: enhance existing GH_CONFIG_DIR architecture with a transparent function proxy + token health monitoring.
