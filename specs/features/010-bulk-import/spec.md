# Bulk import

Status: in-progress

## UI mock

Development entry: Import data beside Add item on `/items`, not Settings or Upcoming. Drawer supports CSV template download, UTF-8 CSV file selection or pasted text, editing, validation, row preview and simulated import confirmation. Mobile uses full-screen drawer.

Mock limits: 1 MB, 500 records. Required columns: name,type,due_date; optional amount,currency. Reject duplicate/unknown headers, malformed quotes, invalid dates (YYYY-MM-DD), unsupported types, missing/long names, negative or >2-decimal amounts and missing/malformed three-letter currencies when amount is supplied. Currency syntax validation is not a definitive supported-currency list. Reader supports quoted commas, escaped quotes, multiline cells and BOM. Duplicate name/type/date combinations within the CSV are flagged; saved items are not checked.

All rows must pass before simulation. Editing CSV invalidates preview. File errors preserve previous input. Closing drawer keeps state until page unmount/reload. Simulation reports explicitly that no real items were created. No API requests, DB writes or email processing.

## Pending backend work

Backend owns final schema/validation/limits, currency support, duplicate policy, persistence, batch atomicity, error reporting and reminder behavior. This mock does not establish the backend contract.

## Excel mock

Import accepts `.xlsx` alongside CSV. ExcelJS is lazy-loaded when selecting Excel; visible sheets appear in a selector. Date cells become YYYY-MM-DD; values are converted to editable CSV and pass the same validation. Each sheet is limited to 500 data rows / 5 columns, file to 1 MB. Formula cells are rejected; users must paste values first. Legacy `.xls` requires conversion to `.xlsx`. Sheet switching clears validation; no backend changes.
