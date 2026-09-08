# Inbox

## Goal

Cho phép người dùng quản lý các mục việc nhanh cần xử lý, tách biệt với note kiến thức.

## Scope

- `anyrem-desktop`: inbox page, create/edit/delete và complete state.
- `anyrem-be`: inbox item CRUD và filter completion/date.

## Behavior

- Inbox item có name và trạng thái completed.
- Người dùng có thể tạo, đổi tên, xoá và toggle completed state.
- Danh sách có thể filter theo trạng thái hoàn thành và khoảng thời gian.
- Inbox item không tự trở thành note.

## Acceptance Criteria

- Toggle state tồn tại sau khi tải lại danh sách.
- Filter chỉ trả item thuộc user hiện tại.
- Xoá item không ảnh hưởng note hoặc category.
