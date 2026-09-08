# Tracked Items

Status: in-progress

Behavior đã chốt và câu hỏi còn mở được phân biệt bên dưới. Acceptance criteria là dự thảo, chưa phải bằng chứng implementation.

## Goal

Thêm, xem, cập nhật và xóa các mốc cần theo dõi với ít bước; tìm được item khi danh sách lớn hơn.

## Scope and Ownership

Backend sở hữu CRUD, validation, ownership và list queries. Web/PWA sở hữu Add Item, Detail/Edit và All Items. Extension dùng contract tạo item trong [quick capture](../007-chrome-quick-capture/spec.md). Shared tham gia khi có UI tái sử dụng thực tế.

## Confirmed Behavior

- Default fields: Name, Type, Due / Renewal date; label date phù hợp ngữ cảnh expiry/renewal.
- Icon/màu tùy chọn trong More options khi tạo/sửa: danh sách Lucide có tìm kiếm, màu gợi ý và HEX sáu ký tự. Lưu lựa chọn trong mock, dùng ở bảng/detail; item chưa chọn icon tiếp tục dùng icon tự động theo loại. Màu trang trí icon không thay màu cảnh báo deadline.
- More options: Amount, Currency, Billing cycle, Auto renew, Group, URL, Notes, Reminder schedule.
- Amount và group optional; không ép user tổ chức dữ liệu sớm hoặc nhập lại metadata/default hợp lệ.
- Type mô tả item là gì; group mô tả context của user. Các loại cần hỗ trợ về mặt sản phẩm gồm subscription, trial, domain/SSL, credential rotation, warranty, contract và deadline khác; enum cuối cùng chưa chốt.
- Detail/Edit hiển thị name, provider, type, date, amount, recurrence, reminders, group, source URL và notes khi có; edit nhanh.
- All Items cho search, filter theo type/group, sort theo due date/amount; dùng table với các cột Item, Due date, Group, Amount; mobile cuộn ngang trong bảng. Tên item là link mở drawer, hỗ trợ keyboard.
- Reminder editor theo [Notification Settings](../006-notification-settings/spec.md); business logic thuộc backend.
- Chỉ dùng confirmation cho destructive action. Theo dõi credential rotation không yêu cầu lưu token/secret.

## Item Drawer

Add, Detail và Edit dùng drawer bên phải rộng 580px trên desktop, toàn màn hình trên mobile. Dashboard, All Items và Notification Settings vẫn là page. Mở item giữ nguyên page, filters và vị trí cuộn phía sau.

URL `/items/new`, `/items/:id`, `/items/:id/edit` vẫn truy cập và refresh được. Khi mở trực tiếp không có page nền, dùng All Items phía sau. Edit/Save/Cancel chuyển nội dung trong cùng drawer bằng replace history; Back/Escape/nút Close đóng drawer về page đã mở nó. Mantine quản lý focus trap và return focus; header và form actions cố định trong vùng drawer.

## Acceptance Criteria — Draft

- Tạo/xem/sửa item với default fields mà không bắt nhập amount hoặc group.
- More options có thể mở khi cần; dữ liệu đã nhập không mất khi lưu lỗi.
- Item không có amount/group vẫn hiển thị rõ và không tạo chi phí giả định.
- Search/filter/sort phản ánh dữ liệu user theo contract được chốt; có empty state cho bộ lọc không khớp.
- Detail phản ánh bản lưu mới nhất sau edit; backend từ chối thao tác trái quyền và input không hợp lệ.
- Form và danh sách dùng được trên mobile và bằng keyboard; lỗi chỉ rõ bước cần sửa.
- Xóa item có confirmation phù hợp và kết quả phản ánh lại trên list/dashboard.

## Open Questions Before Implementation

- Type enum, required/length limits, provider/icon resolution và metadata defaults?
- Date-only/datetime, timezone, cho phép ngày hôm nay/quá hạn và status lifecycle?
- Recurrence, auto-renew semantics, chuyển kỳ, complete/archive và sửa deadline tác động lịch nhắc thế nào?
- Amount precision, currency default, sort khi thiếu amount hoặc khác currency?
- Search fields, pagination, kết hợp filters và default sort?
- Hard/soft delete, xử lý reminder đang chờ khi xóa; offline PWA có cho nhập/lưu không?

## References

- [Groups](../004-groups/spec.md)
- [API conventions](../../api/conventions.md)
- [UI guidelines](../../design/ui-guidelines.md)

## Optional Time — Mock

Mọi type có Time optional HH:mm. Giờ trống là date-only; dueAt lưu UTC qua mock theo timezone settings, date giữ tương thích. Edit chuyển UTC về timezone user; đổi type giữ giờ, xóa giờ giữ ngày hiển thị. Từ chối giờ DST không tồn tại/nhập nhằng. Chưa thay worker email.

## API Implementation Baseline

Các quyết định API đã chốt nằm tại [ADR 0004](../../decisions/0004-api-auth-and-persistence.md) và [contract backend](../../../repos/soonio-api/docs/api.md). Phần mock/draft phía trên là lịch sử thiết kế; contract mới có ưu tiên với auth, wire format, defaults, date/time và pagination. PostgreSQL/Sanctum/Data + Actions đã triển khai; không chạy gửi email, recurrence rollover hoặc offline writes.

## Deadline and Lifecycle UI Preview — 2026-09-07

User chốt tách hai component: deadline status do backend tính khi đọc, không lưu column; lifecycle `active`, `completed`, `archived` được lưu DB khi backend triển khai. Active đủ điều kiện gửi email theo settings và reminder policy; Completed/Archived không gửi email. Backend do user xử lý sau; increment này chỉ mock UI.

Shared cung cấp `DeadlineStatus` nhận status, countdown và ngày đã định dạng qua props; `ItemStatusAction` nhận lifecycle, labels và callback. Shared không tính deadline, gọi API hoặc lưu dữ liệu. Backend tương lai dùng chung bộ quy tắc thời gian cho query/filter và response, tránh hai bộ logic phân loại độc lập.

Preview development tại `/preview/item-status`, độc lập auth và dữ liệu thật; fixtures cố định ngày 07/09/2026. Có bảng desktop/mobile cuộn ngang, drawer chi tiết, dropdown đổi lifecycle, Undo, search, lifecycle/deadline filters trên URL và empty state. Thay đổi lifecycle chỉ giữ trong phiên, reload reset; không gọi API hoặc gửi email.

Các lựa chọn sau là giả định để review mock, chưa chốt backend: bốn nhãn Upcoming/Due soon/Due today/Overdue; Due soon dự kiến 1–7 ngày, Upcoming sau ngưỡng đó; mặc định lọc Active; Completed/Archived giữ ngày nhưng ẩn cảnh báo; chuyển lại Active giữ deadline; hoàn thành item lặp lại kết thúc toàn item, không tự chuyển kỳ. Fixtures không triển khai thuật toán phân loại hay timezone. Selection cho Overview/Upcoming, aggregate chi phí, xử lý email pending và backfill vẫn cần backend quyết định trước khi tích hợp.

Mock cũng được gắn vào UI chính khi chạy development: `ItemList` hiển thị deadline status và cột lifecycle action, drawer dùng cùng trạng thái trong phiên. All Items/Upcoming/Groups có filter lifecycle trên URL, mặc định Active, và Undo khi đổi trạng thái làm item biến mất khỏi filter. Mock tải đủ các trang của query hiện tại trước khi lọc lifecycle và phân trang local. Deadline adapter tạm dùng countdown/timezone hiện có; khi tích hợp backend phải thay bằng classification trong response. Không thêm status parameter hoặc mutation vào API hiện tại. UI ghi rõ thay đổi không được lưu; email và dashboard aggregates vẫn theo backend. Production giữ luồng cũ cho đến khi backend được nối.
