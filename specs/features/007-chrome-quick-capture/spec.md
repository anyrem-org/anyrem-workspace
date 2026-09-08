# Chrome Quick Capture

Status: draft

Behavior đã chốt và câu hỏi còn mở được phân biệt bên dưới. Acceptance criteria là dự thảo, chưa phải bằng chứng implementation.

## Goal

Từ website đang xem, thêm item với số bước tối thiểu qua Chrome extension.

## Scope and Ownership

WXT + React extension sở hữu lấy metadata tab, form và tương tác platform. Laravel sở hữu auth, validation và tạo item. Shared cung cấp UI tái sử dụng; không gọi Chrome API từ shared.

## Confirmed Behavior

1. User mở website và click extension.
2. Prefill title/domain/url từ tab hiện tại khi truy cập được; user có thể sửa dữ liệu.
3. User nhập due/renewal/expiry date và price nếu có, chọn Type theo form/default được chốt.
4. Save qua API tạo tracked item của user.

Name, Type và Date là default fields theo [Tracked items](../002-tracked-items/spec.md); amount optional. Group và reminder override trong More options, không tăng số field bắt buộc. Reminder modes theo [Notification Settings](../006-notification-settings/spec.md).

Không dùng AI extraction trong MVP. Metadata capture không tự xác định ngày hoặc giá khi chưa có khả năng/behavior được chốt.

## Acceptance Criteria — Draft

- Tab truy cập được cung cấp metadata prefill, user sửa được trước save.
- Có thể tạo item không có amount hoặc group; item lưu thành công xuất hiện qua API/list web sau refresh phù hợp.
- Thiếu metadata không ngăn user nhập thủ công; không mất input khi API lỗi.
- Loading/save state rõ ràng, lỗi có hành động tiếp theo; auth failure theo flow đã chốt.
- Shared UI không phụ thuộc Chrome API; controls hỗ trợ keyboard và viewport nhỏ của extension.
- Custom/Disabled/default inheritance tuân cùng backend policy như web.

## Open Questions Before Implementation

- Popup hay surface Chrome khác; permissions cần thiết và tab URL không hỗ trợ xử lý cụ thể thế nào?
- Default Type và quy tắc title/domain/provider mapping?
- Auth handoff với web, form state khi popup đóng/session hết hạn?
- Duplicate capture, retry/save khi mất mạng và success navigation?
- Group creation có trong extension không; có lưu draft offline không?

## References

- [Authentication](../001-authentication/spec.md)
- [Coding conventions](../../engineering/coding-conventions.md)
- [UI guidelines](../../design/ui-guidelines.md)
