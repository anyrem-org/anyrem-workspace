# Authentication

Status: in-progress

Behavior đã chốt và câu hỏi còn mở được phân biệt bên dưới. Acceptance criteria là dự thảo, chưa phải bằng chứng implementation.

## Goal

Cho user truy cập Soonio và dữ liệu cá nhân từ web/PWA hoặc extension một cách nhất quán.

## Scope and Ownership

`soonio-api` sở hữu authentication/authorization; web và extension sở hữu trải nghiệm đăng nhập và xử lý session theo contract được chốt. Shared chỉ cung cấp UI tái sử dụng nếu có use case, không quản lý session.

## Confirmed Behavior

- Items, groups và settings thuộc user đã xác thực; backend giới hạn mọi truy cập theo owner.
- Client sử dụng auth contract chung do backend sở hữu, với tích hợp phù hợp từng platform.
- UI thông báo khi cần đăng nhập để tiếp tục; không coi dữ liệu client là bằng chứng quyền truy cập.

## Acceptance Criteria — Draft

- User đã xác thực có thể truy cập dữ liệu của mình qua client được hỗ trợ.
- User khác không đọc/sửa/xóa được item, group hoặc settings không thuộc mình, kể cả khi gửi identifier trực tiếp.
- Request thiếu hoặc hết hiệu lực xác thực được xử lý theo contract, UI giải thích hành động tiếp theo.
- Form auth hỗ trợ keyboard, loading và lỗi có thể khắc phục theo UI guidelines.

## Open Questions Before Implementation

- Sign-up/sign-in methods, logout, email verification và password recovery thuộc MVP đến đâu?
- Session/cookie/token cho web và extension, thời hạn, refresh/revocation và storage?
- CSRF/CORS và extension permissions theo auth flow đã chọn?
- Có chia sẻ phiên giữa web/extension không; khi hết phiên có giữ form đang nhập và quay lại flow cũ không?

## References

- [API conventions](../../api/conventions.md)
- [UI guidelines](../../design/ui-guidelines.md)

## API Implementation Baseline

Các quyết định API đã chốt nằm tại [ADR 0004](../../decisions/0004-api-auth-and-persistence.md) và [contract backend](../../../repos/soonio-api/docs/api.md). Phần mock/draft phía trên là lịch sử thiết kế; contract mới có ưu tiên với auth, wire format, defaults, date/time và pagination. PostgreSQL/Sanctum/Data + Actions đã triển khai; không chạy gửi email, recurrence rollover hoặc offline writes.

## Account UI mock — 2026-09-07

Development `/profile` shows Profile, Sign-in/password and Delete account sections. All edits in this screen are session-only mock, not real account mutations. Production retains the existing profile form.

Avatar: compact 64px photo with a camera indicator opens a keyboard-accessible change/remove menu; no separate always-visible action buttons. Select PNG/JPEG/WebP up to 5 MB, validate image decoding, preview round center crop with zoom, save/cancel, remove photo. This is a CSS crop preview; no cropped file is produced or uploaded. Name changes and photo changes do not update the real account.

Explicit mock state selector previews email/password, Google without password, Google with password and unknown backend state. Do not infer has_password from Google linkage. No-password setup requires simulated Google verification; existing-password flow asks current/new/confirmation and provides a simulated email recovery flow. Password fields clear after submission. Google password is never changed; Google sign-in remains available. Final backend password policy and reauthentication are pending.

Delete mock: explain irreversible impact in the real flow, require exact account email, allow cancellation, then show explicit simulation completion. No account/data deletion or logout occurs. Real deletion needs separate backend design for reauthentication, retention and data cleanup before enabling production.

## Two-step verification UI mock — 2026-09-08

Development profile includes an authenticator-based 2FA section beneath password settings. Inspired by [Notion two-step verification](https://www.notion.com/help/two-step-verification), this mock requires a password scenario before setup. One named authenticator is supported; SMS and multiple methods are outside this mock.

Setup shows a clearly non-scannable QR placeholder, device name and demo code validation (`123456`). Confirmation enables local mock state and presents six downloadable demo recovery codes with a saved acknowledgement. Closing setup before verification does not enable 2FA. Closing recovery-code display after verification leaves mock 2FA enabled; codes can be regenerated after verification.

Enabled state offers a standalone sign-in challenge preview (authenticator or single-use recovery code), recovery-code regeneration and disable confirmation. Regeneration and disabling require an active demo factor. Wrong/used codes show an error; regeneration invalidates the old set. Scenario changes and reload reset all state. No real authentication, secret generation, scannable enrollment QR, persistence or login-route enforcement is implemented.

Google copy distinguishes Google-managed sign-in from the email/password challenge. Production enforcement across login methods, enrollment reauthentication, TOTP verification, recovery storage/rate limits and API contracts remain backend decisions, not established by this UI mock.

Profile save control uses a compact, right-aligned “Save changes” button, enabled only for a non-empty changed name. Saving updates the local mock baseline; avatar actions keep their separate preview confirmation.

All profile mock buttons, including password, 2FA and dialogs, use content-sized widths, consistent small typography and a minimum 44px touch target. Labels wrap on narrow screens; save/confirm actions use footer alignment where applicable. Concise action labels omit repeated mock suffixes; surrounding mock notices remain explicit.

## Login presentation — 2026-09-08

AuthGate uses a responsive welcome/form layout: desktop introduction with decorative deadline illustration and a focused form card; mobile stacks a compact introduction above the form and hides the illustration. A subtle forest background, consistent medium inputs and a primary sign-in action establish hierarchy. Existing backend translations, Google availability, errors, locale selection and authentication endpoints are retained. Register shares the presentation; confirmation input is disabled during pending authentication.
