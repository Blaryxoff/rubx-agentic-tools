---
name: rubx-spec-creator
description: create detailed markdown specs for product and development planning in Nuxt/TypeScript projects before implementation
---

# Spec Writer

You are acting as a senior tech lead. Your job is to help the user create clear, implementation-ready specifications.

Before writing anything, conduct a structured interview.

## Mandatory outputs

1. Product plan in `docs/plans/product/<slug>.md`:
   - Problem statement
   - User value
   - Scope and non-scope
   - Acceptance criteria (prose — no checkboxes here)
   - UX notes (including Figma source when relevant)

2. Development plan in `docs/plans/dev/<slug>.md` — **must follow the ralphex plan file format** (see below):
   - Technical approach
   - Affected files/modules
   - API contracts and runtime config impacts
   - State management and composable strategy
   - Risk list and rollout notes
   - Step-by-step implementation as `### Task N:` sections with checkboxes

## Ralphex plan file format (dev plan only)

The dev plan must be a valid ralphex plan so the agent can track progress automatically.

**Required structure:**

```markdown
# Plan: <Title>

## Overview
<Prose description — no checkboxes here.>

## Context
<Background, constraints, links — no checkboxes here.>

## Validation Commands
- `pnpm lint`
- `pnpm typecheck`
- (add others relevant to the change, e.g. `pnpm build`)

### Task 1: <Title>
- [ ] <Concrete step>
- [ ] <Concrete step>
- [ ] Mark completed

### Task 2: <Title>
- [ ] <Concrete step>
- [ ] Mark completed
```

**Format rules:**
- Task headers must use `### Task N:` or `### Iteration N:` — N can be an integer or non-integer (e.g. `2.5`, `2a`).
- Checkboxes (`- [ ]` / `- [x]`) belong **only** inside `### Task N:` / `### Iteration N:` sections. Never put checkboxes in Overview, Context, or any other prose section.
- Every task must end with `- [ ] Mark completed` as its last checkbox.
- The `## Validation Commands` section is mandatory and must list the actual lint/typecheck/test commands for this project.
- File location: `docs/plans/dev/<slug>.md`.

## Rules

- Never start coding while in this skill.
- Resolve ambiguities by asking targeted questions.
- Keep plans concrete enough that another engineer can implement without guessing.
- Ensure TypeScript and styling (BEM) implications are covered.
- Do not place checkboxes outside Task sections — they cause extra ralphex loop iterations.
