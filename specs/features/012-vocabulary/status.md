# Vocabulary Status

Status: implemented

Last Reviewed: 2026-08-30

## Progress

- Specification: documented
- Desktop implementation: not applicable (notes created via MCP use standard note UI)
- Backend API: implemented (`McpNotesController`, `notes.templates.ts`, `bulkCreateNotesFromTemplate`)
- MCP: implemented (`anyrem_get_templates`, `anyrem_bulk_create_from_template`)
- Acceptance: not independently verified

## Implementation notes

- Template registry: `repos/anyrem-be/src/modules/notes/notes.templates.ts`
- MCP routes: `/api/mcp/notes/templates`, `/api/mcp/notes/templates/bulk-create-from-template`
- Default template: `vocabulary`
- Dedupe: normalized title (trim + lowercase), case-insensitive DB match

## Remaining

- E2E verification: bulk create → search → activity → duplicate skip
- Add further templates by registering new entries in `NOTE_TEMPLATES`
