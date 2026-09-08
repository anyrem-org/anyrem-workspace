# Soonio API Conventions

Laravel owns the API contract: [Soonio REST API v1](../../repos/soonio-api/docs/api.md). [ADR 0003](../decisions/0003-api-data-and-actions.md) and [ADR 0004](../decisions/0004-api-auth-and-persistence.md) record accepted architecture and persistence/auth choices.

- REST /api/v1, snake_case JSON; GET reads, POST creates/actions, PATCH partial updates, DELETE removes.
- Resource envelope data; lists data/meta/links, page 1-based, default 10/max 50. Validation errors message/errors with 422. 401 auth, 403 permission, 404 missing, 409 uniqueness conflict, 429 throttling.
- Sanctum sessions/CSRF for web; bearer tokens for extension. Owner derives from authentication, never body user_id. Policies protect individual resources; queries and relationship mutations are user-scoped.
- Spatie Data separates create/update/output. Injected Actions own transactions/business rules. No ViewModel, mass assignment of entire DTO, or automatic upsert.
- Missing PATCH fields preserve values; null clears nullable fields. Backend validates all inputs, including dates/timezone and ownership. Enum machine values stay stable across vi/en.
- PostgreSQL due_date required, due_at nullable UTC; no exclusive CHECK. Money is decimal and serialized as string; aggregates separate currencies.
- Global Email Off blocks all modes; Default inherits dynamically, Custom independent, Disabled silent. No default schedule copies in items.

## Remaining Decisions

OpenAPI tooling, email verification/recovery, full offline PWA writes, recurrence advancement and actual reminder scheduling/retry/deduplication remain outside this increment. No idempotency_key or email worker is introduced. Backend contract updates precede consumer changes; do not treat mock-only documentation as the current wire contract.
