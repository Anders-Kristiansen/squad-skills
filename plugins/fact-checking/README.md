# ✅ Fact Checking Skill

Codifies systematic fact-verification methodology and review output formats. Use this skill to ensure accuracy, build confidence in findings, and produce consistent, structured review reports.

## What It Does

This skill teaches your AI agent to:

- **Review claims systematically** — For each claim, ask what evidence supports or disproves it
- **Test counter-hypotheses** — Generate alternative explanations and evaluate them against data
- **Verify external references** — Validate URLs, package names, API endpoints, and links
- **Flag confidence levels** — Mark findings as Verified, Unverified, or Contradicted
- **Generate structured reports** — Produce consistent, scannable review output

## Trigger Phrases

Use these to invoke the skill:
- `fact check`
- `verify`
- `validate claims`
- `source check`

## Quick Start

### Prerequisites

- Access to relevant data sources (documentation, repositories, APIs, external services)
- Ability to make HTTP requests to validate URLs
- Understanding of the domain being fact-checked

### Example Usage

```
User: "Fact-check this claim: The API endpoint is /users/123"
Agent: [Uses fact-checking skill]
Agent: "✅ **Fact Check Complete**
- Claim: API endpoint is /users/123
- Status: ✅ Verified
- Evidence: Tested endpoint, responds with 200 OK"
```

## Methodology

### Step 1: Identify Claims

Break down the material into verifiable claims:
- Factual statements (URLs exist, package versions, API endpoints)
- Assertions about behavior or capability
- Quantitative claims (numbers, dates, versions)

### Step 2: Generate Evidence Questions

For each claim, ask:
- "What evidence supports this?"
- "What would disprove it?"
- "What alternative explanations exist?"

### Step 3: Test Counter-Hypotheses

Generate and test at least one alternative explanation for each major claim.

### Step 4: Verify External References

For URLs, API endpoints, and package names:
- Make test requests to validate they exist
- Check response codes and formats
- Verify they match the claimed behavior

## Review Output Format

When reviewing material, use this template:

```
### Fact Check — {material name}
**Claims verified:** {count}
**Issues found:** {count}

| # | Claim | Status | Evidence/Notes |
|---|-------|--------|---------------|
| 1 | {claim} | ✅/⚠️/❌ | {supporting or contradicting evidence} |

**Counter-hypotheses tested:**
- {alternative explanation + result}

**Verdict:** {PASS / PASS WITH NOTES / NEEDS REVISION}
```

## Confidence Levels

Mark each finding with a confidence indicator:

- **✅ Verified** — Evidence confirms the claim; no contradictions found
- **⚠️ Unverified** — Cannot confirm or deny; suggest verification method
- **❌ Contradicted** — Evidence disproves the claim; flagged for correction

## Example Review

### Fact Check — Release Notes

| # | Claim | Status | Evidence/Notes |
|---|-------|--------|---------------|
| 1 | Version 2.1.0 released on 2026-03-10 | ✅ | Git tag confirmed; release notes match |
| 2 | Breaking change in API response format | ⚠️ | Migration guide exists but examples incomplete |
| 3 | Performance improved by 40% | ❌ | No benchmark data provided; unsubstantiated |

**Counter-hypotheses tested:**
- Could version be 2.0.9 instead? → No; git log confirms 2.1.0
- Could release date be off by one day? → No; timestamp verified

**Verdict:** PASS WITH NOTES — Migration guide needs examples; remove unsupported performance claim

## Best Practices

1. **Be systematic** — Check every claim, not just suspicious ones
2. **Show your work** — Explain what evidence you found and where
3. **Test alternatives** — Don't stop at the first explanation
4. **Distinguish certainty** — Use confidence markers consistently
5. **Flag for revision** — If contradictions found, mark for author review

## When to Use

✅ **Use fact-checking when:**
- Reviewing documentation before publishing
- Validating technical claims in blog posts or guides
- Checking code examples before committing
- Verifying external links and references
- Testing API/package claims before recommending

❌ **Don't use fact-checking for:**
- Subjective opinions or style preferences
- Content that's already been through peer review
- Trivial claims unlikely to mislead readers

## See Also

- [News Broadcasting](../news-broadcasting/) — Compile and deliver team updates
- [Reflect](../reflect/) — Capture learnings from verification work

