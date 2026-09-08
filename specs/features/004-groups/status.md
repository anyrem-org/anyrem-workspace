# Groups Status

Status: in-progress

Last Reviewed: 2026-09-05

## Progress by Repository

| Repository | Progress |
| --- | --- |
| `soonio-web` | Mock tương tác: Tạo group và filter/chọn group trong item form; sidebar desktop, chips và nút tạo group trên mobile. |
| `soonio-api` | Chưa triển khai/tích hợp feature; chưa kiểm chứng backend acceptance. |
| `soonio-extension` | Chưa triển khai trong đợt mock web. |
| `soonio-shared` | Theme, EmptyState và ReminderEditor export qua package local; không có API/platform dependency. |

## Acceptance State

Browser smoke đã qua tạo group desktop và mở/đóng group dialog bằng keyboard trên mobile. Rename/delete group và backend ownership chưa triển khai.

TypeScript check và production demo build đã qua. Đây là kiểm chứng mock UI, không phải production/API acceptance. Các tiêu chí trong [spec](spec.md) còn draft; không chuyển toàn feature sang implemented/verified.

## Limits and Next Step

[README web](../../../repos/soonio-web/README.md) ghi phạm vi, cách chạy pnpm và mọi giả định chỉ dành cho mock. Dữ liệu localStorage chỉ thuộc demo; chưa auth thật, email delivery hoặc offline PWA. Chốt Open Questions liên quan trước khi thay mock adapter bằng Laravel API và kiểm chứng toàn bộ feature.

## API Integration Update — 2026-09-05

Backend: implemented auth, CRUD groups/items, settings/options, dashboard và effective reminder policy; tests PostgreSQL xác minh 5 cases/53 assertions ở thời điểm cập nhật. React: kết nối Axios thật, cookie auth và options vi/en; kiểm thử trình duyệt đang thực hiện. Email worker/recurrence advancement chưa triển khai. Feature tổng thể chưa đánh dấu verified.
