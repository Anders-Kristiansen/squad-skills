---
name: github-multi-account
description: Transparent gh proxy that auto-routes commands to the correct GitHub account based on repo context. Uses GH_CONFIG_DIR isolation — no more account-switching chaos.
confidence: medium
---

# GitHub Multi-Account Proxy

> Confidence: medium — proxy architecture is proven in production via `ghe`/`ghp` wrappers; the transparent layer is new.

## Problem

When you have two GitHub accounts (EMU work + personal), every `gh` command risks running against the wrong identity. The original approach used `gh auth switch` aliases (`ghp`/`ghw`), but three friction points remained:

1. **Cognitive load** — users must remember `ghe` vs `ghp` for every command
2. **Token expiry** — expired tokens in `~/.config/gh-emu` or `~/.config/gh-public` silently break automation (including Ralph)
3. **Git credential gap** — `git push/pull` uses the global credential helper, ignoring GH_CONFIG_DIR isolation

## Solution

A transparent `gh` PowerShell function that intercepts every `gh` call, detects which account to use from the git remote URL, sets `GH_CONFIG_DIR`, and delegates to the real `gh.exe`. Combined with a token health monitor and git credential helper integration.

**Key insight:** The existing `GH_CONFIG_DIR` isolation architecture is 90% there — the proxy just makes it transparent. No new dependencies, zero changes to Ralph.

## How It Works (with the proxy)

```
User/script types: gh pr list
    │
    ├─ Is GH_CONFIG_DIR already set? ──YES──► delegate to gh.exe (respect explicit choice)
    │                                          ◄── Ralph sets this in Step -1
    │                                          ◄── ghe/ghp set this explicitly
    │
    └─ NO → detect from git remote URL
         │
         ├─ Remote matches "tamirdresher_microsoft"
         │  └─► GH_CONFIG_DIR = ~/.config/gh-emu
         │
         ├─ Remote matches "tamirdresher/"
         │  └─► GH_CONFIG_DIR = ~/.config/gh-public
         │
         └─ No remote / no match
            └─► GH_CONFIG_DIR = ~/.config/gh-emu (default = work)
```

### Components

| Component | File | Purpose |
|-----------|------|---------|
| Transparent proxy | `gh-proxy.ps1` | Auto-routes `gh` → correct `GH_CONFIG_DIR` |
| Token health | `gh-proxy.ps1` | `Test-GhTokenHealth` / `Repair-GhToken` functions |
| Setup script | `setup.ps1` | One-time installation of proxy + credential helper |
| Routing table | Configurable in `gh-proxy.ps1` | Maps remote URL patterns → config dirs |

### Routing Table

The proxy uses a regex routing table to match git remote URLs:

```powershell
$script:GH_ROUTING_TABLE = @(
    @{ Pattern = 'tamirdresher_microsoft'; ConfigDir = "$HOME\.config\gh-emu";    Label = 'EMU' }
    @{ Pattern = 'tamirdresher/';          ConfigDir = "$HOME\.config\gh-public"; Label = 'Personal' }
)
$script:GH_DEFAULT_CONFIG = "$HOME\.config\gh-emu"  # Default to EMU (work context)
```

### Token Health Monitor

Proactively check if tokens are valid before they break automation:

```powershell
# Check all profiles
Test-GhTokenHealth

# Check specific profile
Test-GhTokenHealth -Profile emu

# Repair expired token (opens browser)
Repair-GhToken -Profile public
```

### Git Credential Integration

After setup, `git push/pull` also respects GH_CONFIG_DIR:

```powershell
git config --global credential.helper '!gh auth git-credential'
```

## Setup

### Quick Install

```powershell
# From the plugin directory:
.\setup.ps1

# Or manually: dot-source the proxy in your $PROFILE
. "path\to\gh-proxy.ps1"
git config --global credential.helper '!gh auth git-credential'
```

### Prerequisites

- GitHub CLI (`gh`) installed and authenticated for both accounts
- Isolated config dirs already created:
  - `~/.config/gh-emu/` — EMU/work account
  - `~/.config/gh-public/` — personal account
- If not set up yet, run `setup-gh-isolated-auth.ps1` first (from the team scripts)

### Verify

```powershell
# Token health check
Test-GhTokenHealth

# Should show both profiles healthy:
#   Name    Account                  Healthy Error
#   ----    -------                  ------- -----
#   emu     tamirdresher_microsoft   True
#   public  tamirdresher             True

# Test auto-routing (run from a personal repo)
cd ~/repos/some-personal-repo
gh api user --jq '.login'   # → tamirdresher

# Run from a work repo
cd ~/repos/some-emu-repo
gh api user --jq '.login'   # → tamirdresher_microsoft
```

## Files

| File | Description |
|------|-------------|
| `SKILL.md` | This skill document (AI reads this to understand the setup) |
| `README.md` | Human-readable overview and install instructions |
| `gh-proxy.ps1` | Transparent proxy function + token health monitor |
| `setup.ps1` | One-time setup: installs proxy to $PROFILE, configures git credential helper |
| `manifest.json` | Plugin metadata and version |

## Integration with Ralph

**Ralph needs zero changes.** Here's why:

1. Ralph already sets `GH_CONFIG_DIR` in Step -1 (ralph-watch.ps1 lines 1086-1098)
2. The proxy's FIRST check is "Is GH_CONFIG_DIR already set?" — if yes, it delegates immediately without overriding
3. The proxy is a complete no-op when Ralph is running

### Token Expiry Alerting

Add to Ralph's Step -1 for proactive monitoring:

```powershell
$health = Test-GhTokenHealth -Profile $(if ($remoteUrl -match 'tamirdresher_microsoft') { 'emu' } else { 'public' })
if (-not $health.Healthy) {
    Write-Host "Token expired for $($health.Name). Manual re-auth needed." -ForegroundColor Red
}
```

## Backward Compatibility

- `ghe` / `ghp` explicit wrappers continue to work (they set GH_CONFIG_DIR, proxy respects it)
- `gh-auto-context.ps1` prompt hook becomes OPTIONAL (proxy handles auto-detection)
- CMD wrappers (`gh-emu.cmd`, `gh-personal.cmd`) unchanged
- Agents can gradually switch from `ghe`/`ghp` to bare `gh` for in-repo commands

## For Squad Agents

**You no longer need to use `ghe`/`ghp` for in-repo commands.** The transparent proxy auto-detects the correct account. Use bare `gh` freely:

```powershell
# These all auto-route correctly based on repo context:
gh pr list
gh issue create --title "Fix bug"
gh api user --jq '.login'
```

**Still use `ghe`/`ghp` when:**
- Running commands outside a git repo (e.g., `ghe repo list`)
- Explicitly targeting a specific account regardless of repo context
