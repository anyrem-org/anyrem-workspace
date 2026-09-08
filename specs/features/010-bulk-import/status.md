# Bulk import status

Status: in-progress
Last Reviewed: 2026-09-07

- Development UI mounted on `/items` beside Add item. Settings unchanged. CSV upload/paste/template, validation preview, row errors and simulated import implemented.
- No real items created, no backend API changes.
- Frozen-lockfile install, TypeScript, 5 test files (including CSV parsing/validation regression) and build pass. Full check blocked by an existing unused SupportButton import in SettingsPage.tsx outside this change. Build has large-chunk warning.
- Browser not verified; prior Chrome escalation declined. Parser tests do not verify drawer/file-picker/mobile interactions.

## Excel — 2026-09-07

- Added pinned ExcelJS 4.4.0 and updated pnpm lockfile. `.xlsx` reader, visible sheet selection, date normalization and formula rejection reuse CSV validation.
- TypeScript, 6 test files including actual workbook round-trip/formula rejection, and build pass. Full check still blocked by the existing unused SupportButton import in Settings. Browser remains unverified.
