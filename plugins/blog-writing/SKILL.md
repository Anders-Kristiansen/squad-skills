---
name: blog-writing
description: Blog post quality patterns for technical writing — storytelling structure, code block rules, series conventions, and pre-publish checklists.
confidence: high
---

# Skill: Blog Writing

> Patterns for high-quality technical blog posts that read like a conversation, not a manual.

---

## 1. Writing Voice

Write like you're talking to another engineer over coffee. Casual but precise — never academic, never marketing-speak.

### Patterns to follow

| Pattern | Detail |
|---------|--------|
| **Storytelling-first** | Every post opens with a personal story, not a feature list. |
| **Casual but precise** | Technical claims always have specifics: real numbers, real repo names, real outcomes. Never vague. |
| **Real experiments, not theory** | Every concept is backed by something you actually did. Show the experiment, not the hypothesis. |
| **Honest reflection sections** | Every post has a "here's what actually broke" moment. Credibility comes from transparency. |
| **TLDR-style hooks** | Opening paragraphs state the payoff immediately, then unpack. |
| **Direct address** | "Here's the thing nobody tells you about..." Speak to the reader. |
| **Parenthetical asides** | Conversational interjections that add personality. |

### Anti-patterns to avoid

- **Marketing voice.** Never "leverage," "unlock," "empower," or "revolutionize."
- **Hedging.** Don't say "it might be useful to consider." Say "here's what I did."
- **Abstract without concrete.** Every claim needs a real example, a real number, or a real failure.
- **Forced humor.** Jokes work because they're rare and self-aware. One per post max.

---

## 2. Blog Post Structure

Every post follows a consistent storytelling arc:

```
Hook → Context → Experiment → What Worked → What Broke → Insight → Solution → What's Next
```

| Section | Purpose |
|---------|---------|
| **Hook** | Personal story or confession that makes the reader lean in |
| **Context** | Frame the problem in terms the reader recognizes |
| **Experiment** | Describe what you actually tried — repo names, team setup, real configs |
| **What Worked** | Celebrate wins with specifics |
| **What Broke** | Honest failures — this is the credibility section |
| **Insight** | The "aha" moment connecting the failure to a deeper truth |
| **Solution** | The feature/pattern/approach that emerged. Always with real config/code. |
| **What's Next** | Tease the next post AND genuine future directions |

### Structural conventions

- **Horizontal rules (`---`)** separate major sections.
- **H2 (`##`) for major sections.** H3 (`###`) for sub-sections. Never H1 in the body.
- **Bolded key sentences** within paragraphs for scanability.
- **Blockquotes** for thematic quotes and series navigation.
- **Italics** for emphasis on single words or short phrases.

---

## 3. Code Block Rules

### Do

- **Always link to real repos.** Every code block should reference a real file, real PR, or real repo.
- **Keep blocks short.** 5–15 lines ideal. If longer, trim and say "(trimmed for readability)."
- **Use the right language tag.** `markdown`, `bash`, `json`, `yaml`, `powershell` — always explicit.
- **Show real output.** Commit messages, config files, directory structures — all from actual repos.

### Don't

- **Never show theoretical/hypothetical code.** If it doesn't exist in a repo, don't show it.
- **Never show full scripts.** Link to the repo instead.
- **Never show credentials, webhook URLs, or tokens.** Use `<url>` placeholders.

### Directory tree format

Use indented text with `├──`, `└──`, and `│` for directory structures.

---

## 4. Series Conventions

### Series navigation

If writing a multi-part series, every post ends with an identical navigation block. The current post is marked with `← You are here`:

```markdown
> 📚 **Series: Your Series Name**
> - **Part 1**: [Title](/blog/YYYY/MM/DD/slug)
> - **Part 2**: [Title](/blog/YYYY/MM/DD/slug) ← You are here
> - **Part 3**: [Title](/blog/YYYY/MM/DD/slug)
```

**Critical rule:** When adding a new post to a series, update the nav block in **ALL existing posts**.

### Forward/backward links

- Open each post by referencing the previous.
- Close each post by teasing the next.

### Front matter

```yaml
---
layout: post
title: "Subtitle — Descriptive Title"
date: YYYY-MM-DD
tags: [relevant, tags, here]
series: "Series Name"
series_part: N
---
```

---

## 5. Image Rules

| Rule | Detail |
|------|--------|
| **One hero image** | Placed after the hook, before the first `---`. |
| **Captions in italics** | Always on the line directly below the image. |
| **Alt text** | Descriptive, not decorative. |
| **Blurred screenshots** | When showing real project boards or issues, blur sensitive data. |

---

## 6. Pre-Publish Checklist

```markdown
- [ ] Links work — Every internal and external link resolves
- [ ] Images exist — Every image path has a corresponding file
- [ ] Series nav updated in ALL posts — Adding Part N means updating Parts 0 through N-1
- [ ] No "coming soon" placeholders — Replace with real links or remove
- [ ] No leaked HTML — Check for raw tags that should be markdown
- [ ] Code blocks have language tags — Every fenced block has a language
- [ ] Front matter complete — title, date, tags, series, series_part all present
- [ ] Captions are italic — Every image caption uses `*caption text*` format
- [ ] No sensitive data — Webhook URLs, tokens, real emails replaced
- [ ] Repo links valid — All repo links point to real, public repos
- [ ] Date in filename matches front matter
```

---

## 7. What Went Wrong — Lessons Learned

| Problem | Lesson |
|---------|--------|
| **Broken cross-links** | Always update series nav in ALL posts when publishing a new one. Multi-file PR. |
| **Leaked HTML tags** | Search for `</output>`, `<function_results>` and similar agent tooling residue. |
| **Missing images** | Include image files in the same PR as the blog post. |
| **Auth confusion** | Before pushing, verify you're authenticated to the correct account. |
| **Series nav inconsistency** | If a translated version doesn't exist for a post, link to the original version as fallback. |
| **Post date mismatch** | Finalize publication date before adding forward references. Grep for old dates when changing. |
