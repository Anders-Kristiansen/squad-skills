# 🔄 Cross-Machine Coordination

**Git-based task queuing** for AI agents running on different machines — laptop, DevBox, cloud VM, all working together.

## What It Does

- Distributes tasks across multiple machines using Git as the transport
- Schema-validated task definitions ensure consistent execution
- Sandboxed execution with result passing
- No external infrastructure required (no Redis, no message queues)

## How It Works

Uses a Git repository directory structure (`.squad/cross-machine/tasks/` and `results/`) as a task queue. Agents poll for new tasks, claim them via atomic file operations, execute in sandboxes, and push results back.

## Requirements

- Git repository accessible from all machines
- GitHub CLI (`gh`) for notifications
- Agents running on each machine

## Files

- **SKILL.md** — Full agent-consumable knowledge with task schemas, execution patterns, and error recovery

## Quick Example

Tell your AI agent:
> "Run the performance benchmarks on the DevBox and report back"

The skill teaches the agent to create a task file, push it to the coordination branch, and wait for results from the remote machine.
