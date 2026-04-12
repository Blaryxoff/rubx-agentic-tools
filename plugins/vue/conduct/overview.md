# Vue Conduct

This section contains Vue-specific conventions only.

## Scope

- Component boundaries and responsibilities
- Composable extraction and reuse rules
- State ownership patterns

## Boundaries

- Do not place Inertia transport rules here.
- Do not place Tailwind or generic CSS ownership rules here.
- Reference `plugins/core/conduct/ownership-map.md` when in doubt.

## Component structure

- Vue components must have a **single root element**. Multiple root elements cause issues with attribute inheritance and transitions.

## Safe rendering

- Do not use `v-html` with user-controlled content — it introduces XSS vulnerabilities.
- If `v-html` is necessary, sanitize the input before rendering.

## List spacing

- Use `gap-*` on the parent flex or grid container for spacing between list items.
- Do not use individual margins (`mb-4`, `mt-2`, etc.) on each child item — this scatters spacing logic and makes it harder to maintain consistently.
