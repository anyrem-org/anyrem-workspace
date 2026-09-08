# Dashboard / Upcoming Status

Status: in-progress

Last Reviewed: 2026-09-05

## Progress by Repository

| Repository | Progress |
| --- | --- |
| `soonio-web` | Mock tương tác: Overview/Upcoming responsive, attention cards, danh sách horizon và summary từ mock fixtures. |
| `soonio-api` | Chưa triển khai/tích hợp feature; chưa kiểm chứng backend acceptance. |
| `soonio-extension` | Chưa triển khai trong đợt mock web. |
| `soonio-shared` | Theme, EmptyState và ReminderEditor export qua package local; không có API/platform dependency. |

## Acceptance State

Browser smoke đã qua desktop/mobile render, navigation, không tràn ngang ở 390px và không có runtime error. Business rules chỉ là giả định mock trong README web.

TypeScript check và production demo build đã qua. Đây là kiểm chứng mock UI, không phải production/API acceptance. Các tiêu chí trong [spec](spec.md) còn draft; không chuyển toàn feature sang implemented/verified.

## Limits and Next Step

[README web](../../../repos/soonio-web/README.md) ghi phạm vi, cách chạy pnpm và mọi giả định chỉ dành cho mock. Dữ liệu localStorage chỉ thuộc demo; chưa auth thật, email delivery hoặc offline PWA. Chốt Open Questions liên quan trước khi thay mock adapter bằng Laravel API và kiểm chứng toàn bộ feature.

Dashboard mock đã đổi Needs attention thành preview compact tối đa 4 items, breakdown và link xem đầy đủ qua attention filter; không tăng số hàng theo lượng deadline.

## API Integration Update — 2026-09-05

Backend: implemented auth, CRUD groups/items, settings/options, dashboard và effective reminder policy; tests PostgreSQL xác minh 5 cases/53 assertions ở thời điểm cập nhật. React: kết nối Axios thật, cookie auth và options vi/en; kiểm thử trình duyệt đang thực hiện. Email worker/recurrence advancement chưa triển khai. Feature tổng thể chưa đánh dấu verified.

## Upcoming Deadlines Card Update — 2026-09-06

Web: card đếm theo type trong 30 ngày tới. Hover/focus/bấm mở popover tối đa 10 item, cuộn, link detail và View items lọc theo type. Tải đầy đủ pagination từ API Upcoming; không đổi API contract hoặc shared UI.

Validation: `pnpm typecheck`, `pnpm test` (3 test files) và `pnpm build` qua trên Node 22.23.1. Build còn cảnh báo chunk lớn hơn 500 kB. Chưa kiểm chứng tương tác hoặc responsive trong trình duyệt cho thay đổi này.
