# 🔄 Restart Recovery Plugin

Snapshot and restore your full dev environment after a machine restart.

## What It Does

- **Before restart**: Captures running services, active Copilot CLI sessions, Ralph backlog state, and pending git work
- **After restart**: Restores everything automatically — services, sessions, and context
- **Auto-trigger**: Optional Task Scheduler (Windows) / systemd (Linux) / launchd (macOS) integration

## Installation

### As a Copilot CLI Skill

Copy `SKILL.md` to your project's `.copilot/skills/restart-recovery/SKILL.md` or `.squad/skills/restart-recovery/SKILL.md`.

### Scripts

Copy `scripts/recover-from-restart.ps1` (Windows) or `scripts/recover-from-restart.sh` (Linux/Mac) to your project's `scripts/` directory.

## Usage

### Snapshot (before restart)

In Copilot CLI, say:
> "I'm about to restart — snapshot everything"

Or tell Squad:
> "Save state for restart recovery"

### Recovery (after restart)

**Option 1 — Automatic (if auto-trigger is set up):**
Just log in. Task Scheduler / systemd / launchd runs the recovery script.

**Option 2 — Manual (in Copilot CLI):**
> "Recover from restart"

**Option 3 — Direct script:**
```powershell
# Windows
.\scripts\recover-from-restart.ps1

# Linux/Mac
./scripts/recover-from-restart.sh
```

### Auto-trigger Setup

See the SKILL.md for Task Scheduler, systemd, and launchd setup instructions.

## Security

- ✅ Allowlist-only service launching (no arbitrary command execution)
- ✅ Path traversal protection
- ✅ UUID format validation for session IDs  
- ✅ No shell injection — snapshot values never interpolated into commands

## Related

- [`session-recovery`](../session-recovery/) — Find and resume individual past sessions
- This plugin handles full environment restore (multiple services + sessions + state)

## License

MIT — see [LICENSE](../../LICENSE)
