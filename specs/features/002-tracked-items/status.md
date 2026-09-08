# Tracked Items Status

## Deadline and Lifecycle Preview — 2026-09-07

- Shared: thêm `DeadlineStatus` và `ItemStatusAction`, presentation-only qua public exports.
- Web: preview development `/preview/item-status` dùng fixtures độc lập; bảng, drawer, đổi trạng thái/Undo, filters trên URL và empty state. Không nối lifecycle vào API thật, không lưu DB hoặc đổi email behavior.
- Validation: Node 22.23.1, `pnpm install --frozen-lockfile`, ESLint, TypeScript, 3 test files và production build pass. `pnpm check` dừng ở Prettier do 18 file ngoài scope có formatting lỗi sẵn; file thay đổi được format riêng. Build có cảnh báo chunk lớn hơn 500 kB.
- Browser: chưa verified. Chrome trong sandbox bị chặn; yêu cầu chạy ngoài sandbox bị từ chối. Dev server preview chạy cổng 5174.
- Backend integration, deadline calculation/query consistency và lifecycle persistence thuộc phần user xử lý sau. Feature chưa đánh dấu verified.

### Main UI integration — 2026-09-07

- Development: gắn `DeadlineStatus` và lifecycle dropdown vào `ItemList` (bao gồm dashboard) và item drawer; trạng thái UI dùng chung trong phiên. All Items/Upcoming/Groups thêm filter Status trên URL và Undo, lấy đủ trang trước khi lọc/phân trang local.
- Adapter deadline tạm dùng dữ liệu ngày giờ hiện có; không thay backend contract hoặc ghi lifecycle vào DB. Production giữ luồng cũ. Email và summary aggregates chưa phản ánh lifecycle mock; UI có thông báo giới hạn.
- ESLint, TypeScript, 3 test files và production build pass sau tích hợp; `pnpm check` vẫn bị chặn bởi 18 file formatting ngoài scope. Browser vẫn chưa verified do quyền chạy Chrome đã bị từ chối.

### Table columns and deadline progress — 2026-09-07

- Sửa layout mock năm cột: CSS trước đó chia 100% cho bốn cột, làm cột Status bị ép. CSS module định nghĩa lại tổng width năm cột, min-width và căn giữa theo chiều dọc; mobile cuộn ngang trong bảng.
- `DeadlineStatus` thêm meter mức độ gần hạn trên thang 30 ngày, nhận phần trăm qua props, giới hạn 0–100 và có accessible label. Drawer dùng thanh lớn hơn; Completed/Archived ẩn meter. Đây không phải phần trăm hoàn thành.
- ESLint, formatting file trong scope, TypeScript, 3 test files và build pass. Check tổng vẫn vướng 18 file formatting ngoài scope; browser chưa verified.

### Status filters — 2026-09-07

- Development: Deadline status (All/Upcoming/Due soon/Due today/Overdue) và lifecycle filter chỉ hiển thị trong Filter drawer; đã bỏ hai control phía trên bảng theo yêu cầu user. Filters lưu URL, áp dụng cùng các bộ lọc hiện có, reset page và được tính trong filter count.
- Deadline filter và nhãn hiển thị dùng chung `mockDeadlineStatus`; lọc toàn bộ kết quả đã tải trước khi phân trang. API/backend chưa thay đổi; browser chưa verified.

- Gộp Deadline status và Due window thành một control “Thời hạn” trong drawer development. Khi chưa chọn deadline cụ thể, control phản ánh window hiện tại từ Upcoming/Needs attention hoặc URL cũ; chọn deadline thay window và xóa attention/summary trong draft. URL có deadline_status ưu tiên bỏ window cũ, tránh lọc ngày hai lần. Lifecycle Status vẫn độc lập. ESLint, TypeScript, tests và build pass; check tổng còn formatting lỗi sẵn ngoài scope.

Status: in-progress

Last Reviewed: 2026-09-05

## Progress by Repository

| Repository | Progress |
| --- | --- |
| `soonio-web` | Mock tương tác: CRUD, Detail/Edit, All Items với search/type/group filter và due date/amount sort; RHF/Zod validation, localStorage mock qua Axios + TanStack Query. |
| `soonio-api` | Chưa triển khai/tích hợp feature; chưa kiểm chứng backend acceptance. |
| `soonio-extension` | Chưa triển khai trong đợt mock web. |
| `soonio-shared` | Theme, EmptyState và ReminderEditor export qua package local; không có API/platform dependency. |

## Acceptance State

Browser smoke đã qua create/edit/delete, required fields, thiếu amount/group, search empty state, reload persistence và form mobile.

TypeScript check và production demo build đã qua. Đây là kiểm chứng mock UI, không phải production/API acceptance. Các tiêu chí trong [spec](spec.md) còn draft; không chuyển toàn feature sang implemented/verified.

## Drawer Verification

Đã chuyển Add/Detail/Edit sang drawer 580px desktop, toàn màn hình mobile. Browser smoke đã qua create/edit/save, giữ group filter và search khi đóng, Escape, Back/Forward, refresh, direct URL và chiều rộng mobile 390px. Header và form actions sticky; dùng focus management của Mantine Drawer.

## Limits and Next Step

[README web](../../../repos/soonio-web/README.md) ghi phạm vi, cách chạy pnpm và mọi giả định chỉ dành cho mock. Dữ liệu localStorage chỉ thuộc demo; chưa auth thật, email delivery hoặc offline PWA. Chốt Open Questions liên quan trước khi thay mock adapter bằng Laravel API và kiểm chứng toàn bộ feature.

## API Integration Update — 2026-09-05

Backend: implemented auth, CRUD groups/items, settings/options, dashboard và effective reminder policy; tests PostgreSQL xác minh 5 cases/53 assertions ở thời điểm cập nhật. React: kết nối Axios thật, cookie auth và options vi/en; kiểm thử trình duyệt đang thực hiện. Email worker/recurrence advancement chưa triển khai. Feature tổng thể chưa đánh dấu verified.

## Native time input — 2026-09-07

Item Add/Edit dùng `type="time"`, `step=60` thay input text cho giờ tùy chọn. Giữ giá trị HH:mm, cho bỏ trống, prefill timezone và validation/conversion hiện có. Giao diện chọn giờ phụ thuộc trình duyệt; browser chưa verified.
