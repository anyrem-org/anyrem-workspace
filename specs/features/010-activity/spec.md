# Activity

## Goal

Giúp người dùng biết note nào vừa được tạo, xem, sửa hoặc pin để tiếp tục công việc.

## Scope

- `anyrem-desktop`: recent activity panel và note preview/navigation.
- `anyrem-be`: activity event recording và recent activity aggregate API.

## Behavior

- Activity event ghi nhận created, viewed, edited, pinned và unpinned cho note.
- Recent activity trả today count và danh sách event kèm note liên quan.
- Activity chỉ hiển thị dữ liệu của user hiện tại.

## Acceptance Criteria

- Các event mới xuất hiện theo thời điểm gần nhất.
- Activity trỏ đến note hợp lệ hoặc xử lý an toàn khi note không còn khả dụng.
- User không thấy activity của user khác.
