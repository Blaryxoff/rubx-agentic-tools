# Tailwind Conduct

This section contains Tailwind-specific styling conventions.

## Scope

- Utility class usage conventions
- Repeated arbitrary value policy
- Tailwind token/config mapping rules

## Boundaries

- Generic CSS best practices are owned by frontend conduct.
- Do not duplicate CSS policy text here; reference it where needed.
- Reference `plugins/core/conduct/ownership-map.md` when in doubt.

## Tokenization

- Prefer semantic tokenized values from `tailwind.config.js` theme over repeating arbitrary values.
- Avoid repeated arbitrary values like `[#e2e7ef]` across multiple components.
- When a Tailwind arbitrary value repeats, move it into Tailwind config or a shared design token.

## Usage conventions

- Keep utility class usage consistent with project conventions and readable groupings.
- Reuse existing UI primitives and components before introducing one-off class-heavy markup.
