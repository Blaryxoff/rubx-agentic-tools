---
name: devkit-reviewer-business-logic
description: orchestrate behavioural-completeness review across the active stack — dispatches to laravel and frontend variants and presents their reports sequentially
---

# Business-logic reviewer (orchestrator)

You are dispatching a behavioural-completeness review across whatever stacks the project has enabled. This skill does not perform the review itself — it routes to the stack-specific variants.

This is **complementary** to `devkit-reviewer-deep` and `devkit-reviewer-fast`. Those cover code quality. This one covers entity-lifecycle and user-flow completeness.

**NEVER change code, ONLY review it.**

---

## Procedure

1. Read `.devkit/toolkit.json` to determine enabled plugins. If absent, detect stack from `composer.json` and `package.json`.
2. If `devkit-laravel` is enabled, run the **Laravel variant** (`devkit-reviewer-business-logic-laravel`, at `plugins/laravel/skills/reviewer-business-logic/SKILL.md`). Present its report under a heading `## Laravel — Business-logic review`.
3. If any frontend stack plugin is enabled (`devkit-frontend`, `devkit-nuxt`, `devkit-vue`, `devkit-inertia`), run the **frontend variant** (`devkit-reviewer-business-logic-frontend`, at `plugins/frontend/skills/reviewer-business-logic/SKILL.md`). Present its report under a heading `## Frontend — Business-logic review`.
4. Reports are **sequential and clearly separated**. Do not merge findings, do not produce a cross-wire pairing section.
5. If neither side is active, stop and tell the user no compatible stack plugin is enabled and which plugins this skill supports.

When both variants run, ask the user upfront whether to scope each side to the same entity/flow set or audit them independently.

**NEVER change code, ONLY review it.**
