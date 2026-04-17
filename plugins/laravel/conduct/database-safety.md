---
description: Canonical database safety policy for this repository
alwaysApply: true
---

# Database Safety

## STRICTLY FORBIDDEN — never run without explicit written approval in the current session

- `php artisan migrate:fresh` — drops ALL tables and reruns all migrations
- `php artisan migrate:refresh` — same destruction, with optional seeding
- `php artisan migrate:reset` — rolls back all migrations
- `php artisan db:wipe` — drops all tables, views, and types

## Always use

```bash
php artisan migrate
```

Runs only pending migrations without touching existing data.

## Zero-downtime migration discipline

For columns on large tables, follow this sequence:
1. Add column as `nullable` (no default required, no lock)
2. Backfill existing rows in a Job or migration chunk
3. Add index or constraint
4. Switch application code to use the new column
5. Make `NOT NULL` / drop old column in a follow-up migration

Never add a `NOT NULL` column without a default to a table with existing rows in a single migration step.
