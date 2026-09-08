# User feedback status

Status: in-progress
Last Reviewed: 2026-09-07

## Progress

- Web: development feedback button in app topbar; responsive drawer, vi/en form, conditional bug fields, local image selection/previews/removal, validation, direct submission from the form and explicit mock confirmation (review step removed).
- Backend: not implemented; no feedback or upload requests, no maintainer notification.
- Docs: feature spec and status created. Product workflow limits remain mock assumptions pending backend design.

## Validation

Node 22.23.1; frozen-lockfile install, ESLint, TypeScript, existing 4 test files and production build pass. Changed files formatted with local Prettier. Full `pnpm check` stops at 18 pre-existing formatting failures outside scope. Build retains large-chunk warning.

Browser interaction and mobile appearance not verified: prior request to run Chrome outside sandbox was declined. File handling and feedback interaction still require browser verification; existing tests do not cover this new UI.
