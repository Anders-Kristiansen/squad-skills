# 🧩 Squad Skills Marketplace

Reusable skills for [GitHub Copilot Squad](https://github.com/bradygaster/squad) — drop-in automation modules that AI agents can discover and use.

## Available Skills

| Skill | Description | Status |
|-------|-------------|--------|
| [teams-ui-automation](skills/teams-ui-automation/) | Hybrid Teams automation — Playwright + keyboard shortcuts + window management | ✅ Verified |
| [teams-monitor](skills/teams-monitor/) | Monitor Microsoft Teams channels via WorkIQ for actionable messages and bridge them into GitHub issues | ✅ Production |
| [cross-machine-coordination](skills/cross-machine-coordination/) | Git-based task queuing for multi-machine agent coordination with schema validation and sandboxed execution | ✅ Production |
| [github-project-board](skills/github-project-board/) | Manage GitHub Projects V2 board state synchronization with issue lifecycle | ✅ Production |
| [github-distributed-coordination](skills/github-distributed-coordination/) | GitHub-native distributed work claiming protocol for multi-machine agents using atomic comments and labels | ✅ Production |

## How to Use

Copy any skill folder into your project's `.squad/skills/` directory:

```bash
# Example: add Teams UI Automation to your squad
cp -r skills/teams-ui-automation /path/to/your/repo/.squad/skills/
```

Your squad agents will automatically discover and use skills from `.squad/skills/`.

## Contributing

Have a useful automation pattern? Add it as a skill:

1. Create a folder under `skills/{skill-name}/`
2. Add a `SKILL.md` with triggers, recipes, and usage patterns
3. Add any supporting scripts
4. Open a PR

## License

MIT
