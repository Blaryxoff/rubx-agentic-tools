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

## Component design

- Keep components focused on rendering and interaction wiring. Business logic belongs in composables or services.
- Keep component APIs simple and avoid over-generalization.
- Favor explicit props/events contracts over implicit coupling.
- Vue components must have a **single root element**. Multiple root elements cause issues with attribute inheritance and transitions.

## Composables and state

- Extract reusable behavior into composables when logic repeats across components.
- Keep state ownership clear: prefer local component state first; use shared state only when multiple unrelated components need it.

## Safe rendering

- Do not use `v-html` with user-controlled content — it introduces XSS vulnerabilities.
- If `v-html` is necessary, sanitize the input before rendering.

## List spacing

- Use `gap-*` on the parent flex or grid container for spacing between list items.
- Do not use individual margins (`mb-4`, `mt-2`, etc.) on each child item — this scatters spacing logic and makes it harder to maintain consistently.
