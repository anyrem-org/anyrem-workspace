# Authentication Status

Status: draft

Last Reviewed: 2026-09-05

## Progress by Repository

| Repository | Progress |
| --- | --- |
| `soonio-api` | Chưa triển khai trong phạm vi feature Soonio; chưa kiểm chứng. |
| `soonio-web` | Chưa triển khai trong phạm vi feature Soonio; chưa kiểm chứng. |
| `soonio-extension` | Chưa triển khai trong phạm vi feature Soonio; chưa kiểm chứng. |

`soonio-shared`: chưa tạo component/package trong scope tài liệu; chỉ tham gia khi có UI tái sử dụng thực tế.

## Acceptance State

Chưa kiểm chứng. Các tiêu chí trong [spec](spec.md) là dự thảo; không kế thừa kết quả hoặc trạng thái implementation của sản phẩm trước.

## Next Step

Chốt các Open Questions ảnh hưởng phần sắp triển khai, sau đó implement và kiểm tra tại repository owner. Cập nhật status bằng bằng chứng thực tế.

## API Integration Update — 2026-09-05

Backend: implemented auth, CRUD groups/items, settings/options, dashboard và effective reminder policy; tests PostgreSQL xác minh 5 cases/53 assertions ở thời điểm cập nhật. React: kết nối Axios thật, cookie auth và options vi/en; kiểm thử trình duyệt đang thực hiện. Email worker/recurrence advancement chưa triển khai. Feature tổng thể chưa đánh dấu verified.

## Account UI mock — 2026-09-07

- Development profile now renders AccountMock: avatar selection/zoom/removal, local profile editing, explicit password/Google scenarios, simulated verification/recovery and email-confirmed deletion simulation.
- No real account mutations in this development screen; production ProfileForm retained. Avatar crop is visual only. Real upload/remove, password verification/setup and deletion remain backend integration work.
- Frozen install, TypeScript, existing 6 test files and build pass. Full check blocked by existing unused SupportButton import in SettingsPage outside scope. Files formatted locally.
- Browser/mobile and new account interactions not verified; prior Chrome escalation declined. Existing tests do not cover the new account UI.

## Two-step verification UI mock — 2026-09-08

- Added TwoFactorMock to development AccountMock: password prerequisite, named authenticator enrollment, QR placeholder, demo verification, recovery download/acknowledgement, challenge preview, single-use recovery codes, regeneration and disable confirmation.
- Mock only; real login and backend unchanged. Account scenario changes/reload reset state. Production enforcement and enrollment security remain pending.
- Frozen install, formatting, TypeScript, existing six test files and production build pass. Full pnpm check stops on the pre-existing unused SupportButton import in SettingsPage.tsx. Build retains the large-chunk warning.
- Browser interactions and responsive rendering not verified. Existing tests do not exercise the new 2FA mock.

## Compact avatar mock — 2026-09-08

- Replaced separate change/remove buttons with a menu opened from the 64px avatar, with camera indicator and helper text. Existing file validation and zoom preview retained.
- Frozen dependencies installed; pnpm update metadata lookup failed but dependency installation completed. Scoped formatting, TypeScript, six existing tests and build pass. Full check still blocked by the existing unused SupportButton import in SettingsPage. Build retains its chunk-size warning.
- Browser/menu/file-picker interactions not verified.

## Profile save button — 2026-09-08

- Compact right-aligned Save changes button; disabled for unchanged/blank names, with local saved-name baseline.
- Scoped formatting, TypeScript, six existing tests and build pass. Full check blocked by the existing unused SupportButton import. Frozen install completed despite an update-metadata lookup warning; build retains chunk-size warning. Browser not verified.

## Consistent profile buttons — 2026-09-08

- Applied scoped button styling to all AccountMock and TwoFactorMock buttons, including portals/dialogs: intrinsic widths, wrapping labels, consistent typography and 44px minimum targets. Shortened action labels while retaining mock notices; aligned password save and recovery completion to the end.
- Frozen install and scoped formatting completed. TypeScript, six existing tests and build pass. Full check remains blocked by the unrelated unused SupportButton import in SettingsPage. Update-metadata lookup and build chunk-size warnings persist. Browser not verified.

## Login presentation — 2026-09-08

- Updated real AuthGate presentation with scoped responsive styles, welcome illustration, forest background, form card and consistent registration fields. Existing authentication requests and translation ownership retained.
- Frozen install and scoped formatting completed. TypeScript, six existing tests and build pass. Full check stops on the existing unused SupportButton import. Package update-metadata lookup and bundle-size warnings remain.
- Browser rendering and login interactions not verified; automated tests do not establish visual correctness.
