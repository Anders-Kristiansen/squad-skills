# 🤝 GitHub Distributed Coordination

**Distributed work claiming using GitHub's native features** — comments, labels, and timestamps as your coordination backend.

## What It Does

- Enables multiple agents to claim work without conflicts
- Automatic lease expiration and recovery
- Stale work detection and reassignment
- Zero external infrastructure (no Redis, no databases)

## How It Works

Uses GitHub issue comments as atomic claim operations and labels as state markers. Agents claim work by posting a structured comment, and the protocol handles conflicts through timestamp ordering.

## Requirements

- GitHub repository with Issues enabled
- GitHub CLI (`gh`) for API operations
- Multiple agents that need to coordinate

## Files

- **SKILL.md** — Full agent-consumable knowledge with claiming protocol, lease management, and recovery patterns

## Quick Example

Tell your AI agent:
> "Claim the next available task from the work queue"

The skill teaches the agent the atomic claiming protocol — post a claim comment, verify no conflicts, apply labels, and begin work with automatic lease management.
