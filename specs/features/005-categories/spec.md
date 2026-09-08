# Categories

## Goal

Cho phép người dùng tổ chức và duyệt note theo chủ đề mà không làm capture trở nên nặng nề.

## Scope

- `anyrem-desktop`: category list/detail, card/list view và category form.
- `anyrem-be`: category CRUD, category overview có search/sort/pagination và danh sách note thuộc category.

## Behavior

- Category có name, description, color và icon; mỗi category thuộc một user.
- Người dùng có thể tạo, sửa, xoá và xem note theo category.
- Một note có thể thuộc nhiều category.
- Category overview và category detail hỗ trợ card hoặc list view. Overview cho phép tìm theo name/description và sắp xếp theo lần cập nhật hoặc số note; category detail giữ các filter note hiện có và list view cho phép sắp xếp theo ngày tạo hoặc cập nhật.
- Category view preference được lưu cục bộ theo user, tách riêng cho overview và detail.

## Acceptance Criteria

- Category trùng tên trong cùng user bị backend từ chối.
- Xoá category đang được note sử dụng phải trả conflict thay vì mất liên kết dữ liệu.
- Category detail chỉ hiển thị note của user hiện tại.
- View đã chọn được dùng lại cho đúng user và màn hình sau khi mở lại ứng dụng.
- Tìm kiếm, sắp xếp và chuyển card/list không làm thay đổi category hoặc note.
