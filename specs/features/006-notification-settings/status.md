# Notification Settings Status

Status: in-progress

Last Reviewed: 2026-09-05

## Progress by Repository

| Repository | Progress |
| --- | --- |
| `soonio-web` | Mock tương tác: Global email switch/default days, item Default/Custom/Disabled, custom editor và Reset to default; persistence mock. |
| `soonio-api` | Chưa triển khai/tích hợp feature; chưa kiểm chứng backend acceptance. |
| `soonio-extension` | Chưa triển khai trong đợt mock web. |
| `soonio-shared` | Theme, EmptyState và ReminderEditor export qua package local; không có API/platform dependency. |

## Acceptance State

4 unit tests mock policy/cost đã qua. Browser smoke đã qua global đổi Default, Custom độc lập, Email Off, Reset và reload persistence. Không gửi email thật.

TypeScript check và production demo build đã qua. Đây là kiểm chứng mock UI, không phải production/API acceptance. Các tiêu chí trong [spec](spec.md) còn draft; không chuyển toàn feature sang implemented/verified.

## Limits and Next Step

[README web](../../../repos/soonio-web/README.md) ghi phạm vi, cách chạy pnpm và mọi giả định chỉ dành cho mock. Dữ liệu localStorage chỉ thuộc demo; chưa auth thật, email delivery hoặc offline PWA. Chốt Open Questions liên quan trước khi thay mock adapter bằng Laravel API và kiểm chứng toàn bộ feature.

## API Integration Update — 2026-09-05

Backend: implemented auth, CRUD groups/items, settings/options, dashboard và effective reminder policy; tests PostgreSQL xác minh 5 cases/53 assertions ở thời điểm cập nhật. React: kết nối Axios thật, cookie auth và options vi/en; kiểm thử trình duyệt đang thực hiện. Email worker/recurrence advancement chưa triển khai. Feature tổng thể chưa đánh dấu verified.

## Due-soon threshold mock — 2026-09-07

- Settings development thêm ngưỡng Due soon: số nguyên 1–365, mặc định 7, nút Apply riêng và thông báo giữ trong phiên. Không ghi API/DB.
- Item deadline và filter dùng chung threshold từ context; màu theo status. Ngưỡng không đổi email schedule hoặc progress scale.
- ESLint, TypeScript, 4 test files (gồm regression ngưỡng 3/7 ngày, today và timed overdue), build pass. `pnpm check` còn bị chặn bởi 18 file formatting ngoài scope. Browser chưa verified; quyền chạy Chrome ngoài sandbox trước đó đã bị từ chối.
