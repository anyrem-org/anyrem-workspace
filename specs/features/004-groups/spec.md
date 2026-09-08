# Groups

Status: in-progress

Behavior đã chốt và câu hỏi còn mở được phân biệt bên dưới. Acceptance criteria là dự thảo, chưa phải bằng chứng implementation.

## Goal

Cho user tổ chức items theo context tùy chỉnh mà không tăng độ phức tạp của việc thêm item.

## Scope and Ownership

Backend sở hữu groups và item membership. Web/PWA sở hữu quản lý groups và filter. Extension có thể chọn group trong More options của quick capture. Shared chỉ cung cấp control dùng chung khi cần.

## Confirmed Behavior

- Group một cấp, không nested folder; tên do user đặt, ví dụ Work, Personal, Infrastructure, Finance, Side Projects.
- Item thuộc tối đa một group hoặc không có group; group optional.
- Group khác Type: Cursor có thể là Type Subscription, Group Work.
- Desktop sidebar có Groups, New Group và danh sách group với item count. Mobile dùng dropdown/chips, có lựa chọn All để bỏ lọc group.
- Không tự tạo các group ví dụ cho user khi chưa có quyết định về seed/default.

## Mock Group Management

Sidebar có New Group và menu Edit/Delete cho từng group. Tên group mở /groups/:groupId với bảng item phân trang và action Edit/Delete. Trang /groups hỗ trợ quản lý trên mobile qua navigation Groups. Modal tạo/sửa và confirmation xóa dùng chung qua feature Groups; không còn quản lý group trong Settings. Mock xóa group giữ item và đặt groupId về null; không đổi deadline/reminder. Item Edit → More options cho chuyển/bỏ group. Semantics backend cho xóa vẫn cần chốt trước implementation thật.

## Acceptance Criteria — Draft

- User có thể tạo group tùy chỉnh và gán/chuyển item vào một group của mình.
- Item có thể bỏ group, vẫn tồn tại và xuất hiện trong All Items.
- Backend không cho gán group của user khác hoặc nhiều group cho một item.
- Filter group và count khớp định nghĩa dữ liệu sau khi được chốt.
- Mobile chọn group không cần sidebar; controls có label và hỗ trợ keyboard.

## Open Questions Before Implementation

- Group naming limits, duplicate names/case sensitivity, ordering và rename flow?
- Xóa group sẽ bỏ membership hay chặn khi còn items; UX confirmation và quyền xóa?
- Count gồm những item status nào; có filter riêng Ungrouped hay không?
- Extension có tạo group trực tiếp hay chỉ chọn group đã có?

## References

- [Tracked items](../002-tracked-items/spec.md)
- [UI guidelines](../../design/ui-guidelines.md)

## API Implementation Baseline

Các quyết định API đã chốt nằm tại [ADR 0004](../../decisions/0004-api-auth-and-persistence.md) và [contract backend](../../../repos/soonio-api/docs/api.md). Phần mock/draft phía trên là lịch sử thiết kế; contract mới có ưu tiên với auth, wire format, defaults, date/time và pagination. PostgreSQL/Sanctum/Data + Actions đã triển khai; không chạy gửi email, recurrence rollover hoặc offline writes.
