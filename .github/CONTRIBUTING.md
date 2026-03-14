# 🤝 Contributing to Squad Skills

Thanks for your interest in contributing! This marketplace thrives on community plugins.

## Adding a New Plugin

### 1. Create the Plugin Folder

```
plugins/
  your-plugin-name/
    manifest.json     # Required: Plugin metadata
    SKILL.md          # Required: Agent-consumable knowledge
    README.md         # Required: Human-readable documentation
    scripts/          # Optional: Supporting scripts
```

### 2. Write the Manifest

Every plugin needs a `manifest.json`:

```json
{
  "name": "your-plugin-name",
  "version": "1.0.0",
  "description": "One-line description of what it does",
  "platforms": ["copilot", "claude", "squad", "any"],
  "triggers": ["keyword1", "keyword2", "related phrase"],
  "author": "Your Name",
  "license": "MIT",
  "files": {
    "skill": "SKILL.md",
    "scripts": ["scripts/helper.ps1"]
  }
}
```

**Fields:**

| Field | Required | Description |
|-------|----------|-------------|
| `name` | ✅ | Kebab-case identifier (must match folder name) |
| `version` | ✅ | Semantic version |
| `description` | ✅ | One-line summary |
| `platforms` | ✅ | Array of supported platforms |
| `triggers` | ✅ | Keywords/phrases that should activate this plugin |
| `author` | ✅ | Your name or GitHub handle |
| `license` | ✅ | License identifier (MIT recommended) |
| `files` | ❌ | Map of file roles to paths |

### 3. Write the SKILL.md

This is the **core of your plugin** — the knowledge file that AI agents consume. Think of it as structured documentation optimized for LLMs.

**Best practices:**

- Start with YAML frontmatter (name, description, triggers, confidence)
- Use clear section headers (Context, Recipes, Error Recovery)
- Include concrete examples and commands
- Document prerequisites and assumptions
- Add error handling patterns
- Keep it self-contained — an agent should need nothing else

**Template:**

```markdown
---
name: your-plugin-name
description: What this plugin teaches agents to do
triggers: ["trigger1", "trigger2"]
confidence: medium
---

# Your Plugin Name

## Context
What problem this solves and when to use it.

## Prerequisites
- Tool X installed
- Access to Y

## Recipes

### Recipe: Do the Main Thing
1. Step one
2. Step two
3. Step three

### Recipe: Handle Edge Case
...

## Error Recovery
| Error | Cause | Fix |
|-------|-------|-----|
| Error X | Bad config | Do Y |

## Anti-Patterns
- ❌ Don't do this
- ✅ Do this instead
```

### 4. Write the README.md

Human-readable documentation. Explain:
- What the plugin does (in plain English)
- Why someone would use it
- Requirements and prerequisites
- A quick example of usage

### 5. Open a Pull Request

1. Fork this repository
2. Create a branch: `add-{plugin-name}`
3. Add your plugin folder with all required files
4. Test that your SKILL.md works with at least one AI platform
5. Open a PR with:
   - Title: `Add plugin: {plugin-name}`
   - Description: What it does and how you tested it

## Quality Guidelines

### ✅ Good Plugins

- Solve a real, reusable problem
- Work across multiple AI platforms
- Include concrete examples
- Handle errors gracefully
- Are self-contained (no undocumented dependencies)

### ❌ Not a Good Fit

- Project-specific configurations (hardcoded IDs, paths, credentials)
- Wrappers around a single CLI command
- Plugins that require proprietary/non-public tools
- Plugins without any testing or validation

## Updating Existing Plugins

- Bump the `version` in `manifest.json`
- Update SKILL.md and README.md as needed
- Note what changed in your PR description

## Code of Conduct

Be kind, be helpful, build cool things. 🚀
