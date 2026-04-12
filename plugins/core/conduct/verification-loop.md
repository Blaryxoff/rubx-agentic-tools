# Verification Loop

Defines the standard verification cycle to run after implementation changes. Stack-specific commands come from active plugin conduct docs.

## The loop

After completing an implementation task (or a coherent subset), run these checks in order:

1. **Build** — the project must compile/bundle without errors.
2. **Lint** — no new linter warnings or errors introduced by the change.
3. **Type check** — static type analysis passes (when applicable to the stack).
4. **Test** — existing tests pass; new tests pass if written.
5. **Security** — no obvious security regressions (exposed secrets, raw SQL, missing auth).

## When to run

- After completing each task in a dev plan.
- Before marking a task as done.
- Before committing — the commit should represent verified, working code.
- After resolving merge conflicts.

## When NOT to run the full loop

- During exploratory/research phases where code is not yet meant to work.
- When the user explicitly asks to skip verification.
- For documentation-only or config-only changes where build/test are irrelevant.

## Failure handling

- If any step fails, fix the issue before proceeding to the next task.
- Do not accumulate failures across tasks — each task should leave the codebase in a passing state.
- If a failure is pre-existing and unrelated to the current change, note it explicitly and continue. Do not silently ignore it.

## Stack-specific commands

This document defines the loop structure. Concrete commands (`pnpm run lint`, `php artisan test`, `cargo check`, etc.) are defined in each stack plugin's conduct docs or in the dev plan's `## Validation Commands` section. The implementer must use the correct commands for the active stack.
