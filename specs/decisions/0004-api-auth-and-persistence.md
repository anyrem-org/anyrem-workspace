# 0004 — API Authentication and Persistence

Status: accepted

Date: 2026-09-05

## Context

User approved implementing Laravel API for React with PostgreSQL, Sanctum, dynamic vi/en and the defaults discussed in the conversation. ADR 0003 Data + Actions remains in force.

## Decision

- PostgreSQL; Laravel user schema preserved. Sanctum cookie sessions for web and independent expiring tokens for extension.
- /api/v1, snake_case JSON, explicit Data output, paginated data/meta/links (10 default, 50 maximum).
- due_date required; due_at optional UTC and authoritative when present. No mutually-exclusive CHECK; no idempotency_key in this increment.
- Groups unique per user after trim/lowercase; deleting group keeps items, deleting item hard-deletes associated rules/deliveries.
- Locale options en/vi come from backend; saved locale controls UI and API messages. Timezone changes keep timed deadlines fixed.
- Recurrence stores unit/interval only. Reminder policy persistence and resolution implemented; email sending and rollover deferred.
- Defaults: English, USD, readable-12, timezone provided by client or UTC, email enabled, 09:00 reminder time, 7/3/1 rules.

## Consequences

Web needs same-site cookie configuration and CORS/stateful host allowlists. Existing mock payloads require mapping to server-generated IDs and snake_case. Reminder delivery cannot be enabled until scheduling/deduplication/retry policy is decided. OpenAPI tooling is not introduced.

## Alternatives Considered

- SQLite production: replaced by user-approved PostgreSQL.
- Tokens stored in React: cookie sessions selected for first-party SPA.
- Exclusive due_date/due_at CHECK and idempotency_key: explicitly excluded by user.
