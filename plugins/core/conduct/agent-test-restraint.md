# Agent Test Restraint

Do not create test files or run test suites unless the user explicitly asks.

This applies to unit tests, integration tests, feature tests, and any other test code that would produce new files or run a test runner.

## What IS expected without being asked

Agents must still verify their own work through other means:

- **Lint** — check for linter violations introduced by the change.
- **Type check** — run static analysis when the stack supports it.
- **Manual review** — read back the written code, trace logic paths, check edge cases.
- **Smoke-check** — verify routes parse, migrations are valid, configs load, etc.
- **Security spot-check** — scan changes for obvious vulnerabilities (exposed secrets, raw SQL, missing auth).

## What requires explicit user request

- Creating new test files (`*Test.php`, `*.test.ts`, `*.spec.js`, etc.).
- Writing test functions or test cases in existing test files.
- Running `php artisan test`, `pnpm run test`, `cargo test`, `go test`, or equivalent.
- Generating test case design documents.

The point is to prevent agents from producing unwanted test artifacts and consuming time on test suites the user did not ask for — not to excuse agents from verifying their code works.
