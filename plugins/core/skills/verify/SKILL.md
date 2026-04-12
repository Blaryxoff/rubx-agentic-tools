---
name: devkit-verify
description: run the verification loop (lint, typecheck, test, security) after implementation changes and report results
---

# Verification Loop Runner

You are acting as a **quality engineer**. Your job is to run the project's verification loop after implementation changes
and report the results clearly.

## Stack-specific commands

If the project uses the devkit toolkit, read `.devkit/toolkit.json` to identify enabled plugins. For each active plugin,
read its conduct docs (`plugins/<plugin>/conduct/`) for verification commands specific to that stack.

Also check the current dev plan's `## Validation Commands` section if one is active — those commands take priority over
generic defaults.

If neither source provides commands, fall back to detecting the stack from project files (`package.json`, `composer.json`,
`Cargo.toml`, `go.mod`, etc.) and use conventional commands.

## Build assumption

Do not run a separate build command. Assume the dev server is already running and will surface compile/bundle errors
automatically. If the dev server reports errors, fix them.

## The loop

Run these steps in order. Stop and report on first failure unless the user asks for a full report.

### 1. Lint

Run the linter on changed files or the full project:

- Laravel: `./vendor/bin/pint --test` or `./vendor/bin/phpstan analyse`
- Node: `pnpm run lint`
- Rust: `cargo clippy`
- Go: `golangci-lint run`

### 2. Type check

Run static type analysis when the stack supports it:

- TypeScript: `pnpm run typecheck` or `npx tsc --noEmit`
- PHP (with PHPStan/Larastan): `./vendor/bin/phpstan analyse`
- Python (with mypy): `mypy .`

Skip this step for dynamically typed stacks without a configured type checker.

### 3. Test

Run the existing test suite only if the user explicitly asked for verification that includes testing.

- Laravel: `php artisan test`
- Node: `pnpm run test`
- Rust: `cargo test`
- Go: `go test ./...`

If the user did not ask for tests, skip this step and mark it as `⏭️ skipped — not requested`.
Do not create new test files or write test code as part of verification.

### 4. Security spot-check

Review the changes (not the full codebase) for obvious security issues:

- Secrets or credentials in code or config files.
- Raw SQL string interpolation.
- Missing authorization on new endpoints.
- User input passed to dangerous functions without sanitization.

This is a quick review, not a full audit. Report findings inline with the other results.

## Output format

```
## Verification Results

| Step       | Status | Notes                          |
|------------|--------|--------------------------------|
| Lint       | ✅/❌  | <one-line summary or "passed"> |
| Type check | ✅/⏭️  | <one-line summary or "skipped — no type checker configured"> |
| Test       | ✅/⏭️  | <one-line summary or "skipped — not requested"> |
| Security   | ✅/⚠️  | <one-line summary or "no issues found"> |
```

If any step failed, include the relevant error output below the table.

## Rules

- Do not fix issues yourself unless the user explicitly asks. Report findings only.
- Do not run destructive commands (database wipes, force pushes, etc.).
- If a failure is clearly pre-existing (exists on the base branch, unrelated to recent changes), mark it as
  `⚠️ pre-existing` rather than `❌`.
- Respect the agent test restraint rule: do not create test files or run test suites unless the user explicitly asked.
  All other verification steps (lint, typecheck, security review) are expected and should always run.
