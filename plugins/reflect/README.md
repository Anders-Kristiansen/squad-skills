# 🔄 Reflect Skill

Codifies a learning capture system for agents to extract patterns from conversations and prevent repeating mistakes. Use after user corrections, praise, or when discovering edge cases.

## What It Does

This skill teaches your AI agent to:

- **Capture learnings** — Extract HIGH/MED/LOW confidence patterns from conversations
- **Prevent mistakes** — Learn from user corrections to avoid repeating errors
- **Reinforce successes** — Document what worked well for future use
- **Handle edge cases** — Identify and remember scenarios that require special handling
- **Propose improvements** — Generate structured recommendations for knowledge base updates

## Trigger Phrases

Use these to invoke the skill:
- `reflect`
- `retrospective`
- `self-improve`
- `lessons learned`
- `what went wrong`

## Quick Start

### Prerequisites

- Access to conversation history
- Ability to read and write to knowledge/history files
- Understanding of confidence levels and learning categories

### Example Usage

```
User: "No, use the code search tools first instead of grep"
Agent: [Uses reflect skill]
Agent: "📝 **REFLECTION**
[HIGH] + Add preference: 'Use code search tools before grep'
Source: User correction about tool performance
Target: Agent knowledge base"
```

## Learning Categories

### HIGH Priority — Corrections & Decisions

Triggered when user actively steers output:
- User explicitly rejects approach: "no", "wrong", "not like that"
- User provides strong directives: "never do", "always do"
- User provides alternative implementation

**Signal:** Explicit feedback + clear direction

### MEDIUM Priority — Success Patterns & Edge Cases

Triggered by user acceptance or discovered gaps:
- User praises output: "perfect", "great", "exactly"
- User modifies output slightly but commits it
- Questions user asks reveal missing scenarios
- Workarounds user has to apply

**Signal:** Implicit feedback + pattern recognition

### LOW Priority — Accumulated Preferences

Triggered by repeated patterns over multiple interactions:
- Consistent tool choice across multiple tasks
- Repeated interaction patterns
- Workflow preferences expressed multiple times

**Signal:** Pattern consistency over time

## Learning Capture Process

### Phase 1: Identify Trigger

Watch for learning signals:

- **User says "no"** → HIGH priority correction
- **User says "perfect"** → MED priority success pattern
- **User asks "what if X?"** → MED priority edge case
- **Repeated behavior** → LOW priority preference

### Phase 2: Extract Learning

Determine what was learned:

```
Source: "{quoted user input or observed behavior}"
Category: {HIGH/MED/LOW}
Type: {correction/success/edge-case/preference}
Learning: "{specific takeaway}"
```

### Phase 3: Propose Target

Where should this learning be stored?

- **Agent history** — Agent-specific learnings from this session
- **Team decisions** — Team-wide guidelines all agents follow
- **Skill improvements** — Recommendations to skill documentation
- **Session notes** — Temporary capture for later review

### Phase 4: Format & Present

```
┌─────────────────────────────────────────────────────────────┐
│ REFLECTION: {target}                                         │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│ [HIGH] + Add constraint: "{specific constraint}"            │
│   Source: "{quoted user correction}"                        │
│   Target: Agent knowledge base                              │
│                                                             │
│ [MED]  + Add preference: "{specific preference}"            │
│   Source: "{evidence from conversation}"                    │
│   Target: Shared team guidelines                            │
│                                                             │
│ [LOW]  ~ Note for review: "{observation}"                   │
│   Source: "{pattern observed}"                              │
│   Target: Session notes only                                │
│                                                             │
├─────────────────────────────────────────────────────────────┤
│ Apply changes? [Y/n/edit]                                   │
└─────────────────────────────────────────────────────────────┘
```

## Confidence Thresholds

| Threshold | Action |
|-----------|--------|
| ≥1 HIGH signal | Always propose (user explicitly corrected) |
| ≥2 MED signals | Propose (sufficient pattern) |
| ≥3 LOW signals | Propose (accumulated evidence) |
| 1-2 LOW only | Skip (insufficient evidence) |

## Example Reflections

### Example 1: User Correction

**Conversation:**
```
Agent: "I'll use grep to search the repository"
User: "No, use the code search tools first, grep is too slow"
```

**Reflection Output:**
```
[HIGH] + Add constraint: "Use code search tools before grep"
  Source: "No, use the code search tools first, grep is too slow"
  Target: Agent knowledge base
```

### Example 2: Success Pattern

**Conversation:**
```
Agent: [Creates detailed documentation with examples]
User: "Perfect! This is exactly the format I want"
```

**Reflection Output:**
```
[MED] + Add preference: "Include examples in documentation"
  Source: User praised detailed format
  Target: Team guidelines
```

### Example 3: Edge Case Discovery

**Conversation:**
```
User: "What if the file doesn't exist?"
Agent: [Realizes error handling gap]
```

**Reflection Output:**
```
[MED] ~ Add edge case: "Handle missing file scenarios"
  Source: User asked about file existence
  Target: Agent knowledge base / skill recommendations
```

## Persistence

After user approval, learnings are captured in:

**Agent History Format:**
```
### {Date}: {Session Title}

**Context:** {Brief description}

**Learnings:**
1. [HIGH] {Constraint learned} — Source: "{user quote}"
2. [MED] {Preference discovered} — Pattern observed
3. [MED] {Edge case} — Scenario: {description}
```

## When to Use

✅ **Use reflect when:**
- User says "no", "wrong", "not like that" (HIGH priority)
- User says "perfect", "exactly", "great" (MED priority)
- You discover edge cases or scenarios not anticipated
- Complex work session with multiple learnings
- After major tasks to consolidate patterns

❌ **Don't use reflect when:**
- Simple one-off questions with no pattern
- User is exploring ideas without decisions
- Learning is already captured in knowledge base
- Trivial preferences unlikely to recur

## Integration Examples

### Storing Agent Learnings

Create or append to agent history:
```
### 2026-03-14: Tool Selection Preference

**Learnings:**
1. [HIGH] Prefer code intelligence tools over grep for symbol search
   — Source: User correction
2. [MED] Include usage examples in API documentation
   — Pattern: User praised examples in 3 sessions
```

### Proposing Team Guidelines

Create team decision proposal:
```
### Decision: Code Search Tool Priority

**Rationale:** Multiple sessions show better results with code intelligence
**Pattern:** 5 corrections suggesting tool ordering
**Recommendation:** Establish tool preference hierarchy
```

## See Also

- [News Broadcasting](../news-broadcasting/) — Share learnings with team
- [Fact Checking](../fact-checking/) — Verify learnings before capturing
- [Distributed Coordination](../cross-machine-coordination/) — Share learnings across agents

