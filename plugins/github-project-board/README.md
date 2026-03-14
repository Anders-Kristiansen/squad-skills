# 📋 GitHub Project Board

**Keep your GitHub Projects V2 board in sync** with issue lifecycle — automatically move cards when status changes.

## What It Does

- Moves issues between board columns (Todo → In Progress → Done, etc.)
- Maps issue labels/states to board columns
- Provides CLI commands for direct board manipulation
- Supports custom column mappings

## How It Works

Uses GitHub CLI (`gh`) with GraphQL mutations to update project item field values. Provides pre-mapped column option IDs for quick status transitions.

## Requirements

- GitHub Projects V2 board
- GitHub CLI (`gh`) with project permissions
- Project ID and field option IDs (documented in SKILL.md)

## Files

- **SKILL.md** — Full agent-consumable knowledge with column mappings, CLI commands, and transition rules

## Quick Example

Tell your AI agent:
> "Move issue #42 to In Progress on the board"

The skill teaches the agent the exact GraphQL mutation and option IDs to update the board.
