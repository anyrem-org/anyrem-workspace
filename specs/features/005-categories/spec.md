# Categories

## Goal

Cho phép người dùng tổ chức và duyệt note theo chủ đề mà không làm capture trở nên nặng nề.

## Scope

- `anyrem-desktop`: category list/detail, card/list view và category form.
- `anyrem-be`: category CRUD và danh sách note thuộc category.

## Behavior

- Category có name, description, color và icon; mỗi category thuộc một user.
- Người dùng có thể tạo, sửa, xoá và xem note theo category.
- Một note có thể thuộc nhiều category.
- Category view preference được lưu cục bộ theo user và scope màn hình.

## Acceptance Criteria

- Category trùng tên trong cùng user bị backend từ chối.
- Xoá category đang được note sử dụng phải trả conflict thay vì mất liên kết dữ liệu.
- Category detail chỉ hiển thị note của user hiện tại.
