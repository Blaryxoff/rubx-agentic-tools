# Database Schema Snapshot

Use `database/schema.snapshot.json` as the primary source of truth for current database structure.

## Rules

- Before reading migrations or models for schema questions, check whether `database/schema.snapshot.json` exists and use it first.
- Use migrations and models only as fallback when the snapshot file is missing or clearly outdated.
- If you detect a mismatch between code and snapshot, mention the mismatch and recommend regenerating via `php artisan db:schema-snapshot`.
