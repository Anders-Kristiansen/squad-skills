# 🎓 Build Your Own Squad — Hands-On Workshop

> **Duration:** ~2 hours  
> **Level:** Beginner to Intermediate  
> **Prerequisites:** GitHub account with Copilot access, Node.js 18+, Git  
> **Last updated:** 2026-03-13

---

## Welcome

In this workshop you'll set up a **multi-agent AI development team** — a Squad — that lives in your repository. Your Squad members have names, expertise, memory, and the ability to work in parallel. By the end, you'll have:

- 🤖 A team of 4–6 specialized AI agents with distinct roles
- 📋 Persistent memory across sessions (decisions, learnings, history)
- 🔄 Automated work monitoring via Ralph
- 🏷️ GitHub Issues integration with label-based routing
- 🧩 Installable skills from the marketplace

**What you won't do:** manually create `team.md`, `routing.md`, or agent charters. The Squad CLI and coordinator handle all of that for you.

---

## Table of Contents

| # | Section | Purpose |
|---|---------|---------|
| 1 | [Prerequisites & Setup](#1-prerequisites--setup) | Tools you'll need |
| 2 | [Install Squad CLI](#2-install-squad-cli) | Get Squad running |
| 3 | [First Conversation](#3-first-conversation-with-squad) | Launch & hire your team |
| 4 | [Your Squad Playground](#4-your-squad-playground) | Talk to agents, explore features |
| 5 | [GitHub Issues Routing](#5-routing-work-with-github-issues) | Pull work from GitHub |
| 6 | [Project Board Tracking](#6-project-board-tracking) | Track work visually |
| 7 | [Ralph — Work Monitor](#7-ralph--work-monitor) | Continuous monitoring |
| 8 | [Skills](#8-skills--extend-your-squad) | Portable knowledge modules |
| 9 | [MCP Integrations](#9-mcp-integrations--extend-capabilities) | Connect Teams, Outlook, etc. |
| 10 | [@copilot Coding Agent](#10-copilot-coding-agent) | Autonomous coder |
| 11 | [Advanced Features](#11-advanced-ceremonies-human-members-cross-machine) | Ceremonies, humans, cross-machine |
| 12 | [Reference Guide](#12-reference--exploration-guide) | Quick reference & tips |

---

## 1. Prerequisites & Setup

⏱️ *~10 minutes*

### Required Tools

| Tool | Install | Purpose |
|------|---------|---------|
| **Git** 2.30+ | [git-scm.com](https://git-scm.com) | Version control |
| **GitHub CLI** (`gh`) 2.40+ | `winget install GitHub.cli` | GitHub API interactions |
| **Node.js** 18+ | [nodejs.org](https://nodejs.org) | Squad CLI runtime |
| **GitHub Copilot CLI** | `gh extension install github/gh-copilot` | AI agent platform |
| **GitHub Account** | — | With Copilot Business/Enterprise access |

### Verify Everything Works

```bash
# Check versions
git --version          # → git version 2.40+
gh --version           # → gh version 2.40+
node --version         # → v18+

# Authenticate GitHub CLI
gh auth login
gh auth status         # Should show ✓ Logged in
```

### Optional but Recommended

| Tool | Why |
|------|-----|
| **VS Code** with Copilot Chat | IDE-integrated agent experience |
| **PowerShell 7+** (`pwsh`) | Automation scripts, Ralph watchdog |
| **MCP servers** | Extend Squad with Teams, Outlook, ADO (see [Section 9](#9-mcp-integrations)) |

> 💡 **Tip:** You can use Squad from the standalone Copilot CLI *or* from VS Code's Copilot Chat — both work. This workshop uses the CLI.

### 🎯 Try It!

Run `gh copilot --help` and confirm you see the Copilot CLI commands. If not, install the extension:
```bash
gh extension install github/gh-copilot
```

---

## 2. Install Squad CLI

⏱️ *~5 minutes*

### Install Globally (Recommended)

```bash
npm install -g @bradygaster/squad-cli
```

Or use without installing:

```bash
npx @bradygaster/squad-cli init
```

### Initialize Squad in Your Repo

Navigate to your repository and run:

```bash
cd my-project
squad init
```

**What `squad init` does automatically:**

1. Creates the `.squad/` directory structure
2. Installs the coordinator agent at `.github/agents/squad.agent.md`
3. Sets up `.gitattributes` merge drivers for append-only files
4. Creates template files for team configuration

**You do NOT need to create any files manually.** The init command handles everything.

### Verify

```bash
squad status
```

You should see output showing your squad is initialized but has no team members yet.

### 🎯 Try It!

Create a new repo and initialize Squad:
```bash
mkdir my-squad-demo && cd my-squad-demo
git init
squad init
ls .squad/        # See what was created
```

---

## 3. First Conversation with Squad

⏱️ *~15 minutes*

Now comes the fun part. Open Copilot CLI and hire your team.

### Launch Copilot CLI with Squad Agent

```bash
agency copilot --yolo --agent squad
```

This boots the Squad coordinator agent directly — no initialization, no steps. Just you and your AI team.

### What Happens

The coordinator immediately engages you:

```
Squad v0.1.0
Hey Sarah, what are you building? (language, stack, what it does)
```

Tell it what you're working on. The coordinator will:
1. **Propose a team** with themed names from a fictional universe
2. **Ask if it looks good** — you can keep it, change roles, add/remove members
3. **Create everything automatically** — `.squad/`, team roster, charters, memory files

Names come from Star Trek, The Matrix, Lord of the Rings, Marvel, etc. — the coordinator picks based on your project. Scribe and Ralph always keep their names.

Example team proposal:
```
🏗️  Picard    — Lead           Scope, decisions, code review
⚛️  Geordi    — Frontend Dev   React, UI, components
🔧  Riker     — Backend Dev    APIs, database, services
🧪  Crusher   — Tester         Tests, quality, edge cases
📋  Scribe    — (silent)       Memory, decisions, session logs
🔄  Ralph     — (monitor)      Work queue, backlog, keep-alive
```

Once you say "Yes, hire this team," you can start working immediately.

### What Got Created

After confirmation, your `.squad/` directory looks like this:

```
.squad/
├── team.md              # Roster with all members
├── routing.md           # Work routing rules (who handles what)
├── ceremonies.md        # Design reviews, retros (auto-triggered)
├── decisions.md         # Team-wide decisions all agents respect
├── decisions/inbox/     # Pending decisions awaiting review
├── casting/
│   ├── policy.json      # Casting rules (allowed universes, capacity)
│   ├── registry.json    # All names ever assigned (persistent)
│   └── history.json     # Assignment snapshots
├── agents/
│   ├── picard/
│   │   ├── charter.md   # Role definition, expertise, boundaries
│   │   └── history.md   # Learnings & memory from past sessions
│   ├── geordi/
│   │   ├── charter.md
│   │   └── history.md
│   └── ...              # One folder per agent
├── skills/              # Installable skill modules
├── log/                 # Session logs
├── orchestration-log/   # Who did what when
└── config.json          # Machine & cross-machine settings
```

**All of this is auto-generated.** You didn't write a single line.

### 🎯 Explore

1. Run `agency copilot --yolo --agent squad`
2. Describe your project (real or imaginary — this is a playground)
3. Let Squad propose a team
4. Confirm or customize
5. Poke around `.squad/` and see what was created
6. Try talking to an agent by name: "Picard, what's our architecture?"

---

## 4. Your Squad Playground

⏱️ *~Explore at your own pace*

Now that you have a team, here's what you can try. This isn't a script — pick what interests you:

### Talking to Agents

Try addressing agents directly:

```
> Picard, review my API design
> Geordi, what would you use for the UI framework?
> Crusher, should we add integration tests?
```

Each agent has expertise. Use them as you would a real team member.

### Parallel Work

Tell multiple agents to work simultaneously:

```
> Team, build a user profile page. We need:
>   - API endpoint (backend)
>   - React component (frontend)  
>   - Test cases (testing)
```

Agents work in parallel, drop their work, Scribe logs everything.

### Decisions & Memory

Important decisions go into `.squad/decisions.md`. Every agent reads it at session start.

Try:
```
> Always use JWT for authentication
> Never commit secrets
> From now on, all PRs need a test plan
```

These become permanent team rules.

### Reference Material: What You Can Explore

- **drops & parallel work:** Agents independently work on pieces, then assemble results
- **decisions.md:** Team memory that persists across sessions
- **agent charters:** `.squad/agents/{name}/charter.md` — read what each agent specializes in
- **orchestration log:** `.squad/orchestration-log/` — see who worked on what

### 🎯 Just Build

Pick something and ask your team to build it. You decide the scope:

- Fix a bug in an existing project
- Build a small feature (e.g., "dark mode toggle")
- Design a system architecture
- Write tests for critical paths
- Document something

There's no "right" way. This is your creative playground.

---

## 5. Routing Work with GitHub Issues

⏱️ *~Optional: Try when ready*

Squad can pull work from GitHub Issues and route it intelligently. Here's how it works:

### Connect Your Repo

During init, Squad asks if there's a GitHub repo with issues. Give your repo name. Squad stores the connection in `.squad/team.md`.

### Label-Based Routing

Squad uses GitHub labels to assign work:

| Label | Meaning |
|-------|---------|
| `squad` | "New work — needs triage" |
| `squad:picard` | "Go to Picard" |
| `squad:geordi` | "Go to Geordi" |
| `squad:copilot` | "Go to @copilot" |

When the Lead sees a `squad` label, they:
1. Read the issue
2. Decide complexity & domain
3. Assign the right `squad:{member}` label
4. Agent picks it up automatically

### The Workflow

```
Issue created → labeled "squad"
Lead triages → assigns "squad:{member}"
Agent picks up → creates branch, does work
PR opened → links the issue
Review → agent or human reviews
Merge → issue auto-closes
```

### Reference Material: What's Available

- **Label setup:** Create `squad`, `squad:picard`, `squad:geordi`, etc. in your repo
- **Triage comments:** Lead explains reasoning — helps agents understand context
- **Branch naming:** `squad/{issue-number}-{brief-description}`
- **Issue lifecycle:** From creation through merge

### 🎯 Try It If Interested

1. Create an issue in your repo
2. Add the `squad` label
3. In your Copilot session: "Check for new issues"
4. Watch the Lead triage and assign it
5. Ask the assigned agent to pick it up

---

## 6. Project Board Tracking

⏱️ *~Optional: For the workflow-minded*

Squad can track work through a GitHub Project board. Here's what that enables:

### The Board

Create a GitHub Project (V2) with columns:
- **Backlog** — pending work
- **In Progress** — agents actively working
- **In Review** — PRs awaiting review
- **Done** — completed & merged

### How Ralph Works

Ralph (the work monitor) scans the board and reports:
- Issues stuck in progress too long
- PRs waiting for review
- Failed CI checks
- Unassigned backlog items

Ralph snapshots the board over time, so you can see trends.

### Automation

When agents work:
- Issue moves **In Progress** when branch created
- Issue moves **In Review** when PR opened
- Issue moves **Done** when PR merges

### Reference Material

- **Board snapshots:** `.squad/board_snapshot.json` — historical board state
- **Column names:** Backlog, In Progress, In Review, Done (or your custom columns)
- **Ralph reports:** Ask "Ralph, what's the board status?" anytime

### 🎯 Try If Interested

1. Create a GitHub Project for your repo
2. Add columns and link a test issue
3. Ask Ralph: "What's the board status?"

---

## 7. Ralph — Work Monitor

⏱️ *~Optional: For continuous monitoring*

Ralph is Squad's work monitor. He doesn't code — he keeps work flowing.

### Starting Ralph

Just ask:

```
> Ralph, go
```

Ralph scans for:
- Open issues with `squad:*` labels
- PRs needing review
- Failed CI checks
- Stale work (stuck too long)

### Running Ralph Persistently

Ralph operates at three levels:

| Level | How | When |
|-------|-----|------|
| **In-session** | Self-chains within your session | While you're talking |
| **Local watchdog** | Run `npx @bradygaster/squad-cli watch` in a terminal | Continuous, on your machine |
| **Cloud heartbeat** | GitHub Actions cron job | Scheduled, no local machine |

Try the local watchdog in a separate terminal:

```bash
npx @bradygaster/squad-cli watch
```

This polls every 10 minutes for new work.

### What Ralph Reports

```
📋 Squad Status Report

Open issues assigned to squad members:
  🔧 Riker — #42: Fix auth endpoint timeout
  ⚛️ Geordi — #38: Add dark mode toggle

PRs needing review:
  #43: Fix timeout handling (awaiting review)

CI Status:
  ✅ All checks passing
```

### Reference Material

- **Report format:** Status, open issues, PR reviews needed, CI health
- **Polling interval:** Configurable (default 10 min)
- **Cloud setup:** GitHub Actions workflow (example in `.squad/` templates)

### 🎯 Try If Interested

1. Say "Ralph, go" in your session
2. Or run `npx @bradygaster/squad-cli watch` in a separate terminal
3. Create an issue with a `squad:*` label — watch Ralph notice it

## 8. Skills — Extend Your Squad

⏱️ *~Optional: Browse and install*

Skills are portable knowledge modules that give agents new capabilities. They're just markdown files with instructions and examples.

### What Skills Provide

Skills let agents do things like:
- Automate Teams and Outlook
- Generate news briefings
- Fact-check claims
- Capture learnings from corrections
- Manage GitHub project boards
- Coordinate across machines

### Finding Skills

Browse: **[github.com/tamirdresher/squad-skills](https://github.com/tamirdresher/squad-skills)**

Available skills include:
- **teams-ui-automation** — Automate Microsoft Teams
- **github-distributed-coordination** — Cross-machine work via Git
- **news-broadcasting** — Daily tech briefings
- **outlook-automation** — Email and calendar control
- **fact-checking** — Verify claims and sources
- **reflect** — Capture learnings from corrections

### Installing a Skill

Copy a skill directory into `.squad/skills/`:

```bash
git clone https://github.com/tamirdresher/squad-skills.git /tmp/squad-skills
cp -r /tmp/squad-skills/plugins/reflect .squad/skills/reflect
```

### Creating Your Own Skill

Create `.squad/skills/{name}/SKILL.md`:

```markdown
---
name: my-skill
description: What this does and when to use it
---

# My Skill

## When to Use
- Trigger conditions...

## Process
1. Step one...
2. Step two...

## Examples
...
```

### Skill Confidence

Skills earn trust:

| Level | Meaning | Behavior |
|-------|---------|----------|
| **LOW** | Brand new | Agents ask before using |
| **MEDIUM** | Works a few times | Automatic, with notification |
| **HIGH** | Reliable | Use anytime |

Confidence grows with successful use, drops on failure.

### Reference Material

- **Skills repo:** [github.com/tamirdresher/squad-skills](https://github.com/tamirdresher/squad-skills)
- **SKILL.md format:** See existing skills for examples
- **Confidence lifecycle:** Tracked in `.squad/skills/{name}/confidence.json`

### 🎯 Try If Interested

1. Browse the skills marketplace
2. Install one that fits your use case
3. Ask an agent to use it
4. Try building your own skill

---

## 9. MCP Integrations — Extend Capabilities

⏱️ *~Optional: For advanced use cases*

**Model Context Protocol (MCP)** servers connect Squad to external systems. This lets agents interact with email, Teams, Azure DevOps, databases, and more.

### What MCPs Add

| Server | Capabilities |
|--------|-------------|
| **Azure DevOps** | Work items, repos, PRs, pipelines, wikis |
| **Teams** | Send/read messages, manage channels |
| **Outlook** | Create meetings, send emails, manage calendar |
| **GitHub** | Issues, PRs, Actions, code search |
| **Playwright** | Browser automation, screenshots, forms |
| **EngineeringHub** | Internal docs search |

### Configuration

MCPs are configured in:
- Global: `~/.copilot/mcp-config.json`
- Per-project: `.vscode/mcp.json`

Example setup:

```json
{
  "mcpServers": {
    "azure-devops": {
      "command": "npx",
      "args": ["-y", "@anthropic/azure-devops-mcp"],
      "env": {
        "AZURE_DEVOPS_ORG": "your-org",
        "AZURE_DEVOPS_PAT": "${env:ADO_PAT}"
      }
    }
  }
}
```

### How Agents Use MCPs

Once configured, agents use MCP tools naturally:

```
> Kes, schedule a design review for tomorrow at 2pm with the team
(Kes uses Outlook MCP to create a meeting)

> Neelix, post the daily update to #engineering
(Neelix uses Teams MCP to send a message)
```

### Reference Material

- **MCP config location:** `~/.copilot/mcp-config.json` or `.vscode/mcp.json`
- **Environment variables:** Passed to MCP servers (e.g., API tokens, org names)
- **Available MCPs:** Check Anthropic's MCP server registry

### 🎯 Try If Interested

1. Check your current config: `cat ~/.copilot/mcp-config.json`
2. Add a new MCP (GitHub is a good start)
3. Reload Copilot
4. Ask an agent to use a tool from that MCP

---

## 10. @copilot Coding Agent

⏱️ *~Optional: Autonomous coding*

GitHub's `@copilot` agent can join your Squad and autonomously pick up issues.

### Adding @copilot

During init, Squad asks if you want `@copilot` on the team. Or add it later:

```bash
squad copilot
```

### When @copilot Excels

Clear capability profile:

| Category | Rating | Notes |
|----------|--------|-------|
| Bug fixes, tests, dependency updates | 🟢 Good fit | Well-defined, bounded |
| Small features with clear specs | 🟡 Needs review | PR review required |
| Architecture, security, design | 🔴 Not suitable | Keep with squad |

### The Workflow

1. Lead triages an issue and marks it as 🟢 good fit
2. Lead adds `squad:copilot` label
3. @copilot auto-assigns on the issue
4. @copilot creates branch, makes changes, opens PR
5. Squad member reviews the PR

### Enabling Auto-Assignment

Add to `.squad/team.md`:

```markdown
<!-- copilot-auto-assign: true -->
```

### Reference Material

- **Capability profile:** What @copilot can and cannot do well
- **Auto-assignment:** Enable/disable in team.md
- **Review workflow:** Always pair @copilot work with squad member review

### 🎯 Try If Interested

1. Create an issue: "Add input validation to the login form"
2. Label it `squad:copilot`
3. Watch @copilot pick it up
4. Review the PR — did it do well?

---

## 11. Advanced: Ceremonies, Human Members, Cross-Machine

⏱️ *~Optional: For deeper integration*

Squad has advanced features you can explore when ready.

### Ceremonies

Automated ceremonies trigger at key moments:

| Ceremony | When | Purpose |
|----------|------|---------|
| **Design Review** | Before multi-agent work | Align on approach |
| **Retrospective** | After failures | Learn from issues |
| **Model Review** | Quarterly | Check agent quality |

Configured in `.squad/ceremonies.md` — auto-generated at init.

### Adding Humans to Your Squad

You can add human team members:

```
> Add Sarah Johnson as Product Owner
```

Humans appear in `team.md` with a 👤 badge:

```markdown
| Sarah Johnson | 👤 Human — Product Owner | Contact: email |
```

Key difference: Humans aren't spawnable — agents **present work and wait** for your input. Communication channels (email, Teams, etc.) are configured.

### Cross-Machine Coordination

Squad can distribute work across multiple machines using Git as a task queue:

```
.squad/cross-machine/
├── tasks/       # Work to be done
└── results/     # Completed work
```

Configure in `.squad/config.json`:

```json
{
  "machineId": "LAPTOP-WORK",
  "peers": {
    "DEVBOX-CLOUD": {
      "teamRoot": "/home/user/project",
      "role": "devbox"
    }
  }
}
```

Machine A queues work for Machine B; results flow back via Git.

### Reference Material

- **Ceremonies:** `.squad/ceremonies.md` — templates and configurations
- **Human members:** How to add, communication channels, handoff patterns
- **Cross-machine:** `.squad/config.json` — machine ID, peer configuration, task queue

### 🎯 Try If Interested

1. Add yourself as a human team member
2. Check `.squad/ceremonies.md` — what's available?
3. Ask: "Picard, run a design review"

---

## 12. Reference & Exploration Guide

⏱️ *~Browse as needed*

This is what you can explore and try. There's no "right" order — build what interests you.

### What's Available

| Feature | Purpose | When to Try |
|---------|---------|-------------|
| **agent charters** | `.squad/agents/{name}/charter.md` — read what each agent knows | When curious about a teammate |
| **decisions.md** | Team memory that persists across sessions | When establishing team rules |
| **Directive capture** | Say "Always..." or "Never..." and it becomes a rule | When you want permanent patterns |
| **Session catch-up** | Ask "What happened while I was away?" | Coming back after a break |
| **Worktree support** | Squad works across Git worktrees | When using git worktree |
| **Model tiers** | Use cheaper models for Ralph/Scribe, standard for coding | For cost optimization |
| **Team fan-out** | Say "Team, build X" to parallelize | For larger work items |

### Quick Reference

| What you want | What to say |
|---------------|-------------|
| Team status | "Status" or "Who's on the team?" |
| Triage issues | "Check for new issues" |
| Start monitoring | "Ralph, go" |
| Run ceremony | "Picard, run a design review" |
| Capture a rule | "Always use TypeScript" |
| Get caught up | "What happened?" |
| Add a member | "Hire a DevOps engineer" |
| Parallel work | "Team, build X" |

### Exploring Deeper

**Directive capture:**
```
> Always use TypeScript strict mode
> Never use var, only const and let
> From now on, all PRs need a test plan
```

These get captured in `.squad/decisions/inbox/` and promoted to `decisions.md`.

**Model tiers for cost:**

| Tier | Model | Use For |
|------|-------|---------|
| **Fast** | claude-haiku-4.5 | Ralph, Scribe, monitoring, formatting |
| **Standard** | claude-sonnet-4.5 | Code generation, architecture, research |
| **Premium** | claude-opus-4.6 | Mission-critical decisions (rare) |

Configure in `.squad/config.json` for each agent.

**Worktree awareness:**

Squad detects Git worktrees and shares `.squad/` across all of them. Decisions and memory are never branch-isolated.

### 🎯 Build Something

Pick an idea and ask your team to build it:
- Fix a bug
- Build a feature
- Design architecture
- Write tests
- Document something

The fun is in discovery. Build YOUR version, not a copy. Explore what Squad can do for YOUR use case.

---

## Troubleshooting

### "Squad not found" or No Agent Response

```bash
# Verify Squad is initialized
squad doctor

# Re-initialize (safe — idempotent)
squad init

# Check the coordinator agent exists
ls .github/agents/squad.agent.md
```

### Labels Not Syncing

Make sure you've created the labels in your repo:

```bash
gh label list | grep squad
```

If missing, create them (see [Section 5](#5-github-issues-integration)).

### Ralph Not Picking Up Work

1. Check GitHub CLI auth: `gh auth status`
2. Ensure you have a PAT with `repo` scope (the default Copilot token may lack permissions)
3. Verify issues have `squad:*` labels

### Agents Don't Remember Previous Sessions

Verify that `.squad/` is committed to Git:
```bash
git status .squad/
```

Agent memory lives in `.squad/agents/{name}/history.md` and `.squad/decisions.md`. If these aren't committed, memory is lost.

---

## What's Next?

Now that you have a working Squad:

1. **Build something real** — give your team a feature to build end-to-end
2. **Install more skills** — browse [github.com/tamirdresher/squad-skills](https://github.com/tamirdresher/squad-skills)
3. **Add MCP integrations** — connect Teams, Outlook, Azure DevOps
4. **Set up persistent Ralph** — run `squad watch` in a background terminal
5. **Share your Squad config** — your `.squad/` directory is portable; others can clone and use it

### Resources

| Resource | Link |
|----------|------|
| Squad CLI Docs | [bradygaster.github.io/squad](https://bradygaster.github.io/squad/) |
| Squad GitHub | [github.com/bradygaster/squad](https://github.com/bradygaster/squad) |
| CLI Reference | [CLI Reference](https://bradygaster.github.io/squad-pr/reference/cli.html) |
| Skills Marketplace | [github.com/tamirdresher/squad-skills](https://github.com/tamirdresher/squad-skills) |
| NPM Package | [@bradygaster/squad-cli](https://www.npmjs.com/package/@bradygaster/squad-cli) |

---

*Built with ❤️ for the Squad community. Happy building!*

---

## Appendix A: GitHub Actions — Hosted Workers & Schedulers

Squad runs 24/7 via automated GitHub Actions workflows. These keep Ralph and other agents awake and responding to work without any manual intervention.

### 1. squad-heartbeat.yml — The Clock That Keeps Ralph Awake

Create .github/workflows/squad-heartbeat.yml:

```yaml
name: Squad Heartbeat
on:
  schedule:
    - cron: '*/10 * * * *'  # Every 10 minutes (or less frequent: '0 * * * *' for hourly)

jobs:
  heartbeat:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: '18'
      - name: Install Squad CLI
        run: npm install -g @bradygaster/squad-cli
      - name: Run Ralph (Squad monitor)
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        run: |
          squad watch --once --output-format json | tee heartbeat-log.json
      - name: Upload logs
        uses: actions/upload-artifact@v3
        with:
          name: heartbeat-logs
          path: heartbeat-log.json
```

**What happens:**
- Every 10 minutes, GitHub Actions spins up a runner
- Ralph wakes up, reads all open issues with \squad:*\ labels
- Runs triage logic, assigns issues to members, posts progress
- Writes logs to artifacts (visible in the Actions tab)

**Cost:** GitHub-hosted runners are free for public repos, 2000 free minutes/month for private repos.

**GITHUB_TOKEN permissions:**
By default, the workflow token has:
- ✅ repo (read/write on issues, PRs)
- ✅ contents (read)

If you need more, create a PAT in \.github/workflows/\ secrets with \epo\ + \workflow\ scopes.

### 2. squad-issue-assign.yml — Auto-Assign When Labeled

Create \.github/workflows/squad-issue-assign.yml\:

```yaml
name: Assign Squad Member
on:
  issues:
    types: [labeled]

jobs:
  assign:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Check if squad label was added
        if: contains(github.event.issue.labels.*.name, 'squad:data') || contains(github.event.issue.labels.*.name, 'squad:picard')
        run: |
          # Map label to assignee from .squad/team.md
          if [[ "${{ github.event.issue.labels.*.name }}" == *"squad:data"* ]]; then
            gh issue edit ${{ github.event.issue.number }} --add-assignee "data-bot"
          fi
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

**Better approach:** Use Squad's routing engine (in \squad.yml\) to auto-assign, or read \.squad/team.md\ and map labels to GitHub usernames.

### 3. squad-triage.yml — Auto-Triage New Issues

Create \.github/workflows/squad-triage.yml\:

```yaml
name: Squad Triage
on:
  issues:
    types: [opened]

jobs:
  triage:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
      - name: Install Squad CLI
        run: npm install -g @bradygaster/squad-cli
      - name: Triage issue with Picard
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        run: |
          squad agent run picard --task "Triage issue #${{ github.event.issue.number }}: ${{ github.event.issue.title }}"
```

Picard (the Lead) reads the issue title and body, then:
- Decides if it's a bug, feature, or chore
- Recommends which squad member should own it
- Applies labels: \squad:data\, \squad:worf\, \priority:high\, etc.

### 4. sync-squad-labels.yml — Keep Labels in Sync

Ensures all team member labels exist in the repo:

```yaml
name: Sync Squad Labels
on:
  push:
    paths:
      - .squad/team.md
    branches: [main]

jobs:
  sync:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Parse team.md and create labels
        run: |
          # Extract names from .squad/team.md and create labels
          cat .squad/team.md | grep "^- " | awk '{print \}' | while read member; do
            gh label create "squad:\" --description "Assign to \" --color "0E8A16" 2>/dev/null || true
          done
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

### 5. Self-Hosted Runners (For EMU & Private Networks)

If your repo is in GitHub Enterprise Managed Users (EMU) or you need runners with special network access:

**On your local machine or DevBox:**

```ash
# Download runner
mkdir actions-runner && cd actions-runner
curl -o actions-runner-linux-x64-2.311.0.tar.gz \
  -L https://github.com/actions/runner/releases/download/v2.311.0/actions-runner-linux-x64-2.311.0.tar.gz
tar xzf ./actions-runner-linux-x64-2.311.0.tar.gz

# Register (get token from repo Settings → Actions → Runners → New self-hosted runner)
./config.sh --url https://github.com/owner/repo --token <TOKEN>

# Run as service (Linux/Mac)
sudo ./svc.sh install
sudo ./svc.sh start
```

**In your workflow:**

```yaml
jobs:
  myJob:
    runs-on: self-hosted  # Or: [self-hosted, linux, x64]
    steps:
      # ... steps ...
```

Self-hosted runners see your network, can access private APIs, and support GPU (if your machine has one).

---

## Appendix B: Teams & Email Integration

For Squad to notify humans and read context, it needs to talk to Teams and Outlook.

### 1. Teams Webhook Setup

**In Microsoft Teams:**

1. Go to the channel where Squad should post updates (e.g., #squad-alerts)
2. Click **⋯ More options** → **Connectors** → **Incoming Webhook** → **Configure**
3. Name: \Squad Notifications\
4. Click **Create**
5. Copy the webhook URL

**Store the webhook:**

```ash
# Save to ~/.squad/teams-webhook.url or .squad/config.json
mkdir -p ~/.squad
echo "https://outlook.webhook.office.com/..." > ~/.squad/teams-webhook.url
chmod 600 ~/.squad/teams-webhook.url
```

Or in \.squad/config.json\:

```json
{
  "teams": {
    "webhook": "https://outlook.webhook.office.com/webhookb2/...",
    "channels": {
      "alerts": "https://outlook.webhook.office.com/...",
      "logs": "https://outlook.webhook.office.com/..."
    }
  }
}
```

**Sending notifications from Ralph:**

```ash
# Webhook payload (Adaptive Card format)
curl -X POST "https://outlook.webhook.office.com/..." \
  -H "Content-Type: application/json" \
  -d '{
    "@type": "MessageCard",
    "@context": "https://schema.org/extensions",
    "summary": "Issue assigned to Data team",
    "themeColor": "0078D4",
    "sections": [{
      "text": "Issue #42: Add user auth",
      "facts": [
        { "name": "Assigned to:", "value": "Data Team" },
        { "name": "Priority:", "value": "High" },
        { "name": "Status:", "value": "In Progress" }
      ],
      "markdown": true
    }],
    "potentialAction": [{
      "@type": "OpenUri",
      "name": "View on GitHub",
      "targets": [
        { "os": "default", "uri": "https://github.com/owner/repo/issues/42" }
      ]
    }]
  }'
```

### 2. Teams MCP Server Integration

The **Teams MCP Server** allows Squad agents to read/write Teams programmatically.

**In \.copilot/mcp-config.json\:**

```json
{
  "mcpServers": {
    "teams": {
      "command": "node",
      "args": ["node_modules/@microsoft/teams-mcp-server/dist/index.js"],
      "env": {
        "TEAMS_WEBHOOK": "https://outlook.webhook.office.com/...",
        "COPILOT_AUTH_TOKEN": "your-token-here"
      }
    }
  }
}
```

**Available tools:**
- \	eams-ListChats\ — Find chats with a user
- \	eams-ListChannels\ — Get channels in a Team
- \	eams-PostMessage\ — Send message to chat
- \	eams-PostChannelMessage\ — Post in channel
- \	eams-ListChatMessages\ — Read recent messages
- \	eams-SearchTeamsMessages\ — Find messages by keyword

**Example: Ralph checks for urgent messages before triaging**

```ash
squad agent run ralph --task "Check Teams for urgent messages about new bugs"
# Ralph uses teams-SearchTeamsMessages with query 'urgent OR critical'
# Adjusts triage priority based on what it finds
```

### 3. Email Watchers (Outlook COM Automation)

For local machines with Outlook installed, use the **outlook-automation** skill:

```ash
# In .squad/config.json
{
  "integrations": {
    "outlook": {
      "enabled": true,
      "checkInterval": 300,  # Every 5 minutes
      "inboxFolder": "Inbox",
      "keywords": ["squad:", "@squad", "urgent"]
    }
  }
}
```

**Ralph can:**
- Read emails with "squad:" in subject
- Extract action items
- Create issues from email subjects
- Send automated replies

### 4. WorkIQ Integration — Workspace Intelligence

**WorkIQ** lets Ralph query Microsoft 365 for:
- Recent emails and their content
- Teams messages and channels
- Shared documents
- Calendar for context

**Setup in \.squad/config.json\:**

```json
{
  "workiq": {
    "enabled": true,
    "refreshInterval": 600,  # 10 minutes
    "queries": {
      "unread_emails": "unread emails from the past 24 hours",
      "urgent_mentions": "messages mentioning @squad or 'urgent'",
      "team_status": "today's team calendar and standup notes"
    }
  }
}
```

**Ralph's workflow:**
1. Runs heartbeat (checks GitHub issues)
2. Queries WorkIQ for new emails + Teams messages
3. Creates issues from urgent context
4. Posts summary to Teams channel

---

## Appendix C: DevBox Setup for Remote Squad

For always-on Squad infrastructure without a local machine:

### 1. Why DevBox?

- ✅ Always-on — no laptop to shut down
- ✅ GPU available (optional, for heavy ML workloads)
- ✅ Isolated environment — no conflict with dev machine
- ✅ Accessible from anywhere via devtunnel
- ✅ Cheap — \.25/hour (~\/month for 24/7)

### 2. Creating a DevBox

**Via Azure Portal:**

1. Go to **Azure portal** → **DevBox**
2. Click **Create** → Choose project, pool (GPU or CPU)
3. Click **Create**
4. Wait ~15 min for provisioning
5. Connect via **DevBox remote desktop**

**Via Azure CLI:**

```ash
az devcenter dev environment create \
  --project-name my-project \
  --environment-type my-env \
  --environment-name squad-devbox
```

### 3. Cloning Your Repo

Once connected to DevBox:

```ash
# On DevBox terminal (PowerShell or bash)
git clone https://github.com/owner/repo.git
cd repo

# Authenticate with GitHub
gh auth login
# (Follow prompts, paste device code into browser)
```

### 4. Installing Copilot CLI on DevBox

```ash
# On DevBox
npm install -g @bradygaster/squad-cli

# Verify
squad doctor
```

### 5. Running Ralph Persistently

Ralph watches for work 24/7:

```ash
# Create a PowerShell script: run-ralph-persistent.ps1
\Continue = 'Continue'
\ = "\C:\Users\tamirdresher/.squad/ralph-persistent.log"

while (\True) {
  try {
    \ = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "\ - Ralph heartbeat starting..." | Add-Content \
    
    squad watch --once 2>&1 | Add-Content \
    
    # Sleep 5 minutes before next check
    Start-Sleep -Seconds 300
  }
  catch {
    "ERROR: \" | Add-Content \
    Start-Sleep -Seconds 60
  }
}
```

**Run as detached process:**

```ash
# On DevBox, run once and let it persist
Start-Process powershell -ArgumentList "-File run-ralph-persistent.ps1" -NoNewWindow

# Or via scheduler (Windows Task Scheduler):
# New-ScheduledTask -TaskName "Squad Ralph" -Action \ -Trigger \
```

**Prevent DevBox from sleeping:**

On Windows, enable **PowerToys Awake**:

```powershell
# Download PowerToys Installer
# https://github.com/microsoft/PowerToys/releases

# Or via winget (if available on DevBox):
winget install Microsoft.PowerToys

# Start Awake module: Settings → Awake → keep awake indefinitely
```

### 6. devtunnel for External Access

If you want to access Squad outputs from your dev machine:

```ash
# On DevBox, forward a port
devtunnel host -p 3000 --allow-anonymous

# On your machine, open the tunnel
devtunnel connect
# Access output at https://<random>.devtunnels.ms
```

### 7. Cross-Machine Coordination

Squad works across multiple machines via a **Git-based task queue**:

```
.squad/
  ├── cross-machine/
  │   └── tasks/
  │       ├── task-001-iss-42-my-laptop.md
  │       ├── task-002-iss-43-devbox.md
  │       └── task-003-iss-44-unclaimed.md
  └── decisions.md
```

**How it works:**

1. **Claim a task:**
   ```ash
   # Ralph on DevBox sees unclaimed task
   gh issue edit #42 --add-assignee "squad-devbox"
   # (or sets a label squad:devbox)
   ```

2. **Work on it:**
   - Branch: \squad/42-fix-auth-devbox\
   - Push changes to a PR
   - Ralph monitors for PR completion

3. **Return results:**
   - Merge PR → task marked done
   - Git log captures who completed it

---

## Appendix D: Webhook & Notification Architecture

### 1. The Complete Notification Flow

```
┌─────────────────────────────────────────────────────────────┐
│ Agent Completes Work (e.g., Ralph triages issue #42)        │
└──────────────────┬──────────────────────────────────────────┘
                   │
                   ▼
┌─────────────────────────────────────────────────────────────┐
│ Scribe Logs Event to .squad/decisions.md                    │
│ - Time, agent name, action, outcome                         │
└──────────────────┬──────────────────────────────────────────┘
                   │
                   ▼
┌─────────────────────────────────────────────────────────────┐
│ Ralph Checks Webhook Config (.squad/config.json)            │
└──────────────────┬──────────────────────────────────────────┘
                   │
                   ▼
┌─────────────────────────────────────────────────────────────┐
│ Ralph Formats Notification (Adaptive Card or Email)         │
│ - Include: issue #, assignee, priority, link               │
└──────────────────┬──────────────────────────────────────────┘
                   │
         ┌─────────┴─────────┐
         │                   │
         ▼                   ▼
   ┌──────────┐         ┌──────────┐
   │ Teams    │         │ Outlook  │
   │ Webhook  │         │ Email    │
   │ POST     │         │ COM Send │
   └────┬─────┘         └────┬─────┘
        │                    │
        ▼                    ▼
   ┌──────────┐         ┌──────────┐
   │ Teams    │         │ Mailbox  │
   │ Channel  │         │ Inbox    │
   │ Alert    │         │ Received │
   └──────────┘         └──────────┘
```

### 2. Setting Up Multiple Webhooks by Severity

Different channels for different alert types:

```json
{
  "teams": {
    "webhooks": {
      "alerts": "https://outlook.webhook.office.com/...",      # Critical issues
      "logs": "https://outlook.webhook.office.com/...",        # Info/debug
      "reviews": "https://outlook.webhook.office.com/...",     # PR reviews
      "metrics": "https://outlook.webhook.office.com/..."      # Metrics/summaries
    },
    "routing": {
      "critical": "alerts",
      "high": "alerts",
      "medium": "logs",
      "info": "logs",
      "pr_review": "reviews",
      "daily_summary": "metrics"
    }
  }
}
```

**Example: Ralph decides which webhook**

```ash
PRIORITY=\

if [[ "\" == "priority:critical" ]]; then
  WEBHOOK="\"
elif [[ "\" == "priority:high" ]]; then
  WEBHOOK="\"
else
  WEBHOOK="\"
fi

curl -X POST "\" -H "Content-Type: application/json" -d '{...}'
```

### 3. Email Notifications as Fallback

If Teams is down, send email:

```ash
# In Ralph's notification logic
if ! curl -f "\" -X POST ... 2>/dev/null; then
  # Teams webhook failed, fall back to email
  # Use Outlook COM automation
  \ = New-Object -ComObject Outlook.Application
  \ = \.CreateItem(0)
  \.To = "squad@company.com"
  \.Subject = "Squad Alert: Issue #42 assigned"
  \.Body = "Issue #42: Add user auth\nAssigned to: Data Team\nPriority: High"
  \.Send()
fi
```

### 4. Adaptive Cards — Rich Format for Teams

Teams notifications use **Adaptive Cards** for interactivity:

```json
{
  "\": "http://adaptivecards.io/schemas/adaptive-card.json",
  "type": "AdaptiveCard",
  "version": "1.4",
  "body": [
    {
      "type": "Container",
      "style": "accent",
      "body": [
        {
          "type": "ColumnSet",
          "columns": [
            {
              "width": "stretch",
              "items": [
                {
                  "type": "TextBlock",
                  "text": "Issue #42: Add User Authentication",
                  "weight": "bolder",
                  "size": "large"
                },
                {
                  "type": "TextBlock",
                  "text": "Assigned to: Data Team",
                  "spacing": "small"
                }
              ]
            },
            {
              "width": "auto",
              "items": [
                {
                  "type": "TextBlock",
                  "text": "🔴 HIGH",
                  "color": "attention",
                  "weight": "bolder"
                }
              ]
            }
          ]
        }
      ]
    }
  ],
  "actions": [
    {
      "type": "Action.OpenUrl",
      "title": "View on GitHub",
      "url": "https://github.com/owner/repo/issues/42"
    },
    {
      "type": "Action.OpenUrl",
      "title": "View Assigned PRs",
      "url": "https://github.com/owner/repo/pulls?assignee=data-team"
    }
  ]
}
```

**Key benefits:**
- One-click links to GitHub
- Color-coded priority
- Readable in Teams mobile app
- No need to leave Teams to take action

---

*These appendices cover the operational infrastructure. Squad runs best when notifications reach the right people at the right time, and when agents can work around the clock without human babysitting.*