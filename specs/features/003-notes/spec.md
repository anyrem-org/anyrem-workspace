# Notes

## Goal

Cho phép người dùng lưu và tiếp tục sử dụng kiến thức cá nhân dưới dạng note rich text.

## Scope

- `anyrem-desktop`: tạo, đọc, chỉnh sửa, liệt kê và pin note bằng BlockNote/Tiptap data.
- `anyrem-be`: note persistence, user scoping, category/related-note validation và search indexing.

## Behavior

- Note có title, rich-text content, category optional, related note optional và trạng thái pinned.
- Người dùng chỉ đọc hoặc thay đổi note của chính họ.
- Note list hỗ trợ pagination, query và category filter.
- Pin/unpin thay đổi trạng thái ưu tiên của note.

## Acceptance Criteria

- Tạo hoặc sửa note được lưu và hiển thị lại đúng nội dung.
- Category và related note không hợp lệ bị backend từ chối.
- Pin state tồn tại sau khi tải lại dữ liệu.
